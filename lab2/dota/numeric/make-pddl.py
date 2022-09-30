import sys
from map import map as chart
template = open(sys.argv[1]).read()

for line in template.splitlines():
    if '<!--U8LIST-->' in line:
        for i in range(256):
            print(f'  u8_{i} - u8')
    elif '<!--U8RULES-->' in line:
        for i in range(256):
            if i+1 < 256:
                print(f'  (succ u8_{i} u8_{(i+1)})')
        for i in range(256):
            for j in range(256):
                if i+j < 256:
                    print(f'  (adds_to u8_{i} u8_{j} u8_{(i+j)})')
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
        print(open(file_to_include).read())

    else:
        print(line)