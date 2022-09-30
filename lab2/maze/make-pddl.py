import sys
from map import map as chart
template = open(sys.argv[1]).read()

NUMBERS = 512
def emit_template(template):
    for line in template.splitlines():

        if '<!--MAPLIST-->' in line:
            for h in range(len(chart)):
                for w in range(len(chart[h])):
                    print(f'  t{w}_{h} - tile')
        elif '<!--MAPRULES-->' in line:
            for h in range(len(chart)):
                for w in range(len(chart[h])):
                    if h!=0:
                        print(f'  (adjacent t{w}_{h} t{w}_{h-1})')
                    if h!=len(chart)-1:
                        print(f'  (adjacent t{w}_{h} t{w}_{h+1})')
                    if w!=0:
                        print(f'  (adjacent t{w}_{h} t{w-1}_{h})')
                    if w!=len(chart[h])-1:
                        print(f'  (adjacent t{w}_{h} t{w+1}_{h})')
                    if 'walk' in chart[h][w]:
                        print(f'  (walkable t{w}_{h})')
                    

        elif '<!--include-->' in line:
            file_to_include = line.split(';')[-1]
            emit_template(open(file_to_include).read())

        else:
            print(line)

emit_template(template)