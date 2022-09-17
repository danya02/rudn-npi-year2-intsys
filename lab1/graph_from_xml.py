import bs4
import sqlite3
db = sqlite3.connect(input('Database file: '))
db.execute('CREATE TABLE IF NOT EXISTS meta(key, value)')
db.execute('DELETE FROM meta')
db.execute('CREATE TABLE IF NOT EXISTS obstacles(node_i, node_j, PRIMARY KEY(node_i, node_j))')
db.execute('DELETE FROM obstacles')
db.commit()
with open(input('XML file: ')) as f:
    soup = bs4.BeautifulSoup(f, 'xml')
    root = soup.find('root')
    start = root.find('start')
    goal = root.find('goal')
    db.execute('INSERT INTO meta VALUES(?, ?)', ('start_node_i', int(start['i'])))
    db.execute('INSERT INTO meta VALUES(?, ?)', ('start_node_j', int(start['j'])))
    db.execute('INSERT INTO meta VALUES(?, ?)', ('end_node_i', int(goal['i'])))
    db.execute('INSERT INTO meta VALUES(?, ?)', ('end_node_j', int(goal['j'])))
    db.commit()

    map = root.find('map')
    width = int(map['width'])
    height = int(map['height'])
    db.execute('INSERT INTO meta VALUES(?, ?)', ('width', width))
    db.execute('INSERT INTO meta VALUES(?, ?)', ('height', height))
    db.commit()

    for j, row in enumerate(map.find_all('row')):
        for i, col in enumerate(row.text.split()):
            if col == '1':
                db.execute('INSERT INTO obstacles VALUES(?, ?)', (i, j))
    db.commit()

options = root.find('options')
db.execute('INSERT INTO meta VALUES(?, ?)', ('algorithm', options['algorithm']))
db.execute('INSERT INTO meta VALUES(?, ?)', ('metrictype', options['metrictype']))
db.execute('INSERT INTO meta VALUES(?, ?)', ('hweight', options['hweight']))
db.execute('INSERT INTO meta VALUES(?, ?)', ('connections', options['connections']))
db.commit()

print('Obstacle count:', db.execute('SELECT COUNT(*) FROM obstacles').fetchone()[0])
print('Metadata:')
for key, value in db.execute('SELECT * FROM meta'):
    print(key, '->', value)

db.close()