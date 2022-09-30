import sys
from map import map as chart
template = open(sys.argv[1]).read()

NUMBERS = 512
def emit_template(template):
    for line in template.splitlines():
        if '<!--NUMLIST-->' in line:
            for i in range(NUMBERS):
                print(f'  n{i} - enum')
        elif '<!--NUMRULES-->' in line:
            for i in range(NUMBERS):
                if i+1 < NUMBERS:
                    print(f'  (succ n{i} n{(i+1)})')
            for i in range(NUMBERS):
                for j in range(NUMBERS):
                    if i+j < NUMBERS:
                        print(f'  (adds_to n{i} n{j} n{(i+j)})')
                    else:
                        print(f'  (overflows n{i} n{j})')
            for i in range(NUMBERS):
                for j in range(NUMBERS):
                    if i>j:
                        print(f'  (greater_than n{i} n{j})')
            

        elif '<!--MAPLIST-->' in line:
            for h in range(len(chart)):
                for w in range(len(chart[h])):
                    print(f'  t{w}_{h} - tile')
        elif '<!--MAPRULES-->' in line:
            for h in range(len(chart)):
                for w in range(len(chart[h])):
                    print(f'  (walkable t{w}_{h})')
                    if h!=0:
                        print(f'  (adjacent t{w}_{h} t{w}_{h-1})')
                    if h!=len(chart)-1:
                        print(f'  (adjacent t{w}_{h} t{w}_{h+1})')
                    if w!=0:
                        print(f'  (adjacent t{w}_{h} t{w-1}_{h})')
                    if w!=len(chart[h])-1:
                        print(f'  (adjacent t{w}_{h} t{w+1}_{h})')
                    if 'F' in chart[h][w]:
                        print(f'  (fountain t{w}_{h})')
                    if 'T' in chart[h][w]:
                        print(f'  (teleportable t{w}_{h})')
        elif '<!--include-->' in line:
            file_to_include = line.split(';')[-1]
            emit_template(open(file_to_include).read())

        else:
            print(line)

emit_template(template)