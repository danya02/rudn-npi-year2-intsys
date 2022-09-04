import random
import sqlite3
db = sqlite3.connect('test.db')
db.execute('CREATE TABLE IF NOT EXISTS edges(antecedent_id, consequent_id, cost)')
db.execute('DELETE FROM edges')
db.execute('CREATE TABLE IF NOT EXISTS meta(key, value)')
db.execute('DELETE FROM meta')
db.execute('INSERT INTO meta(key, value) VALUES(?, ?)', ('start_node_id', 1))
max_id = 50
db.execute('INSERT INTO meta(key, value) VALUES(?, ?)', ('end_node_id', max_id))


def create_edge(ante, cons, cost):
    db.execute('INSERT INTO edges(antecedent_id, consequent_id, cost) VALUES(?, ?, ?)', (ante, cons, cost))
    db.execute('INSERT INTO edges(antecedent_id, consequent_id, cost) VALUES(?, ?, ?)', (cons, ante, cost))  # undirected graph


current_edge = 1
while current_edge < max_id:
    create_edge(current_edge, current_edge + 1, 1000)
    for i in range(1, current_edge):
        if random.random()<0.3:
            create_edge(current_edge, i, random.randint(50, 1000))
    current_edge += 1

db.commit()

# print the graph
for (ante, cons, cost) in db.execute('SELECT * FROM edges'):
    print(ante, cons, cost)

# check with https://wjholden.com/dijkstra