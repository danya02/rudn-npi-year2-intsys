from benchmark_execution import Metrics
data = []
for row in open('results.csv'):
    data += [Metrics(*row.split(','))]

# Calculate the average difference between the path lengths when neighborhod connections are 4 and 8.
avg_4 = 0
avg_8 = 0
rows_4 = 0
rows_8 = 0
for metric in data:
    if 'e' not in metric.path_length:  # Ignore the 'no path' results.
        if metric.connections == '4':
            avg_4 += float(metric.path_length)
            rows_4 += 1
        else:
            avg_8 += float(metric.path_length)
            rows_8 += 1
avg_4 /= rows_4
avg_8 /= rows_8
print("Average path length with 4 connections: {}".format(avg_4))
print("Average path length with 8 connections: {}".format(avg_8))

# Calculate the average difference between the min and max cycle counts for each configuration.
differences = []
# list items in groups of 10
for i in range(0, len(data), 10):
    minv = float('inf')
    maxv = 0
    for row in data[i:i+10]:
        minv = min(minv, int(row.cycles_taken))
        maxv = max(maxv, int(row.cycles_taken))
    differences += [maxv - minv]

print("Average difference between min and max cycles: {}".format(sum(differences) / len(differences)))
print("Max difference between min and max cycles: {}".format(max(differences)))
print("Min difference between min and max cycles: {}".format(min(differences)))

# For every map, algorithm, and metrictype, calculate the min and max number of expansions.
