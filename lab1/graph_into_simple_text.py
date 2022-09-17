import sqlite3
import sys
conn = sqlite3.connect(sys.argv[1])
c = conn.cursor()
def print_meta(key, **kwargs):
    c.execute("SELECT value FROM meta WHERE key = ?", (key,))
    print(c.fetchone()[0], **kwargs)

print_meta("width", end=" ")
print_meta("height")
print_meta("connections")
print_meta("hweight")
c.execute("SELECT value FROM meta WHERE key = 'metrictype'")
metric_type = c.fetchone()[0].lower()
if metric_type == "euclidean":
    print("0")
elif metric_type == "manhattan":
    print("1")
elif metric_type == "octile":
    print("2")
else:
    print('9')

print_meta('start_node_i', end=" ")
print_meta('start_node_j')
print_meta('end_node_i', end=" ")
print_meta('end_node_j')
c.execute("SELECT count(1) FROM obstacles")
print(c.fetchone()[0])
c.execute("SELECT node_i, node_j FROM obstacles")
for row in c:
    print(row[0], row[1])
