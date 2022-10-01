import sys
import json
template = open(sys.argv[1]).read()

TELEPORT_GROUPS = set()
def emit_template(template):
    for line in template.splitlines():

        if '<!--MAPLIST-->' in line:
            map_file = line.split(';')[-1].strip()
            maps = json.load(open(map_file))
            chart = maps['chart']
            for h in range(len(chart)):
                for w in range(len(chart[h])):
                    print(f'  t{w}_{h} - tile')
        elif '<!--MAPRULES-->' in line:
            map_file = line.split(';')[-1].strip()
            maps = json.load(open(map_file))
            chart = maps['chart']
            tiles = maps['tile_types']

            for h in range(len(chart)):
                for w in range(len(chart[h])):
                    cur_tile = chart[h][w]
                    cur_tile = tiles[cur_tile]
                    if h!=0:
                        print(f'  (adjacent t{w}_{h} t{w}_{h-1})')
                    if h!=len(chart)-1:
                        print(f'  (adjacent t{w}_{h} t{w}_{h+1})')
                    if w!=0:
                        print(f'  (adjacent t{w}_{h} t{w-1}_{h})')
                    if w!=len(chart[h])-1:
                        print(f'  (adjacent t{w}_{h} t{w+1}_{h})')
                    if 'walk' in cur_tile:
                        print(f'  (walkable t{w}_{h})')
                    if 'start' in cur_tile:
                        print(f'  (at t{w}_{h})  ;; This is the tile that the agent starts on')
                    for tag in cur_tile:
                        if tag.startswith('teleport-group-'):
                            group = tag.replace('teleport-group-','')
                            print(f'  (teleporter_at t{w}_{h} group_{group})')

        elif '<!--TELEPORTGROUPS-->' in line:
            map_file = line.split(';')[-1].strip()
            maps = json.load(open(map_file))
            chart = maps['chart']
            tiles = maps['tile_types']
            for tile in tiles:
                conf = tiles[tile]
                for item in conf:
                    if item.startswith('teleport-group-'):
                        group = item.replace('teleport-group-','')
                        print(f' group_{group} - teleport_group')

        elif '<!--MAPGOALS-->' in line:
            map_file = line.split(';')[-1].strip()
            maps = json.load(open(map_file))
            chart = maps['chart']
            tiles = maps['tile_types']

            for h in range(len(chart)):
                for w in range(len(chart[h])):
                    cur_tile = chart[h][w]
                    cur_tile = tiles[cur_tile]
                    if 'end' in cur_tile:
                        print(f'  (at t{w}_{h})  ;; This is the tile that the agent should end on')

        elif '<!--include-->' in line:
            file_to_include = line.split(';')[-1]
            emit_template(open(file_to_include).read())

        else:
            print(line)

emit_template(template)