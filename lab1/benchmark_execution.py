import os
import subprocess
import sqlite3
import time

def create_database(xml_map_filename):
    """
    Create a database from an XML map.
    Store it in `test.db`.
    """
    command = "python3 graph_from_xml.py {} test.db".format(xml_map_filename).split()
    subprocess.run(command, stdout=subprocess.PIPE)

def alter_database(algorithm, metrictype, hweight, connections):
    """
    Alter the database to use a specific algorithm and metric type.
    """
    db = sqlite3.connect("test.db")
    cursor = db.cursor()
    cursor.execute("UPDATE meta SET value = ? WHERE key = ?", (algorithm, 'algorithm'))
    cursor.execute("UPDATE meta SET value = ? WHERE key = ?", (metrictype, 'metrictype'))
    cursor.execute("UPDATE meta SET value = ? WHERE key = ?", (hweight, 'hweight'))
    cursor.execute("UPDATE meta SET value = ? WHERE key = ?", (connections, 'connections'))
    db.commit()
    db.close()

class Metrics:
    def __init__(self, map, algorithm, metrictype, hweight, connections, cycles_taken, nodes_constructed, expansions, path_length, total_program_time):
        self.map = map
        self.algorithm = algorithm
        self.metrictype = metrictype
        self.hweight = hweight
        self.connections = connections
        self.cycles_taken = cycles_taken
        self.nodes_constructed = nodes_constructed
        self.expansions = expansions
        self.path_length = path_length
        self.total_program_time = total_program_time
    
    def __str__(self):
        return "{},{},{},{},{},{},{},{},{},{}".format(self.map, self.algorithm, self.metrictype, self.hweight, self.connections, self.cycles_taken, self.nodes_constructed, self.expansions, self.path_length, self.total_program_time)
    def __repr__(self):
        return self.__str__()

def run_search(map, algorithm, metrictype, hweight, connections, iterations=10):
    """
    Create a database and run a search.
    """
    create_database(map)
    alter_database(algorithm, metrictype, hweight, connections)

    text_gen = subprocess.run("python3 graph_into_simple_text.py test.db".split(), stdout=subprocess.PIPE)
    text = text_gen.stdout
    metrics = []
    print("Testing {} with {} and {} and {} and {}".format(map, algorithm, metrictype, hweight, connections))
    for i in range(iterations):
        print("Running iteration {} of {}".format(i+1, iterations))
        start = time.time()
        search_work = subprocess.run("./program.out /dev/stdin".split(), input=text, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        end = time.time()
        search_result = search_work.stdout.decode('utf-8').split('\n')
        for line in search_result:
            if line.startswith('Time taken:'):
                cycles_taken = int(line.split()[2])
            elif line.startswith('Nodes constructed:'):
                nodes_constructed = int(line.split()[2])
            elif line.startswith('Expansions:'):
                expansions = int(line.split()[1])
            elif line.startswith('Path length:'):
                path_length = line.split()[2]
        metrics += [Metrics(map, algorithm, metrictype, hweight, connections, cycles_taken, nodes_constructed, expansions, path_length, end-start)]
    return metrics


def benchmark_all():
    """Run every map as a benchmark and record the results into a file."""
    for map in os.listdir('maps'):
        if map.endswith('.xml'):
            map = 'maps/' + map
            for algorithm in ['astar', 'dijkstra', 'bfs']:
                for metrictype in ['euclidean', 'manhattan', 'octile']:
                    for hweight in ([0.5, 1, 2, 10] if algorithm == 'astar' else [0]):
                        for connections in [4, 8]:
                            metrics = run_search(map, algorithm, metrictype, hweight, connections)
                            with open('results.csv', 'a') as f:
                                for metric in metrics:
                                    print(str(metric).replace(',', '\t'))
                                    f.write(str(metric) + '\n')

def benchmark_some():
    map = 'maps/instance4.xml'
    algorithm = 'astar'
    metrictype = 'euclidean'
    hweight = 1
    connections = 4
    metrics = run_search(map, algorithm, metrictype, hweight, connections, iterations=30)
    with open('results_new.csv', 'a') as f:
        for metric in metrics:
            print(str(metric).replace(',', '\t'))
            f.write(str(metric) + '\n')

if __name__ == '__main__':
    print("Running benchmarks...")
    benchmark_some()