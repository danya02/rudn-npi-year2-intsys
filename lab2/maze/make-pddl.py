import sys
import json
template = open(sys.argv[1]).read()
data = json.load(open(sys.argv[2]))

TELEPORT_GROUPS = set()
def emit_template(template):
    for line in template.splitlines():

        if '<!--MAPLIST-->' in line:
            maps = data
            chart = maps['chart']
            for h in range(len(chart)):
                for w in range(len(chart[h])):
                    print(f'  t{w}_{h} - tile')
        elif '<!--MAPRULES-->' in line:
            maps = data
            chart = maps['chart']
            tiles = maps['tile_types']

            for h in range(len(chart)):
                for w in range(len(chart[h])):
                    cur_tile = chart[h][w]
                    cur_tile = tiles[cur_tile]
                    walkable = True # Every tile is walkable by default
                    if 'wall' not in cur_tile:
                        # For optimization, we can not connect walls to adjacent tiles
                        if h!=0:
                            print(f'  (adjacent t{w}_{h} t{w}_{h-1})')
                        if h!=len(chart)-1:
                            print(f'  (adjacent t{w}_{h} t{w}_{h+1})')
                        if w!=0:
                            print(f'  (adjacent t{w}_{h} t{w-1}_{h})')
                        if w!=len(chart[h])-1:
                            print(f'  (adjacent t{w}_{h} t{w+1}_{h})')
                    else:
                        # If the tile is a wall, it is not walkable
                        walkable = False 

                    if 'start' in cur_tile:
                        print(f'  (at t{w}_{h})  ;; This is the tile that the agent starts on')
                    for tag in cur_tile:
                        if tag.startswith('teleport-group-'):
                            group = tag.replace('teleport-group-','')
                            print(f'  (teleporter_at t{w}_{h} tgroup_{group})')
                            print(f'  (item_at t{w}_{h})')
                        if tag.startswith('block-'):
                            group = tag.replace('block-','')
                            print(f'  (block_at t{w}_{h} bgroup_{group})')
                            print(f'  (item_at t{w}_{h})')
                        if tag.startswith('color-assigner-machine-'):
                            group = tag.replace('color-assigner-machine-','')
                            print(f'  (color_assigner_machine_at t{w}_{h} bgroup_{group})')
                            print(f'  (item_at t{w}_{h}) ;; cannot place blocks on machines')
                        if tag.startswith('teleport-pairer-'):
                            group = tag.replace('teleport-pairer-','')
                            print(f'  (teleport_pairer_at t{w}_{h} tgroup_{group})')
                            print(f'  (item_at t{w}_{h}) ;; cannot place blocks on pairers')
                        if tag.startswith('gate-'):
                            group = tag.replace('gate-','')
                            print(f'  (gate_at t{w}_{h} bgroup_{group})')
                            print(f'  (item_at t{w}_{h}) ;; cannot place blocks on gates')
                            walkable = False # gates are not walkable

                    if 'color-remover-machine' in cur_tile:
                        print(f'  (color_remover_machine_at t{w}_{h})')
                        print(f'  (item_at t{w}_{h}) ;; cannot place blocks on machines')
                    
                    if 'teleport-unpairer' in cur_tile:
                        print(f'  (teleport_unpairer_at t{w}_{h})')
                        print(f'  (item_at t{w}_{h}) ;; cannot place blocks on machines')

                    if walkable:
                        print(f'  (walkable t{w}_{h})')

        elif '<!--TELEPORTGROUPS-->' in line:
            maps = data
            chart = maps['chart']
            tiles = maps['tile_types']
            groups = set()
            for tile in tiles:
                conf = tiles[tile]
                for item in conf:
                    if item.startswith('teleport-group-'):
                        group = item.replace('teleport-group-','')
                        groups.add(group)
            for group in groups:
                print(f' tgroup_{group} - teleport_group')
        elif '<!--BLOCKGROUPS-->' in line:
            maps = data
            chart = maps['chart']
            tiles = maps['tile_types']
            groups = set()
            for tile in tiles:
                conf = tiles[tile]
                for item in conf:
                    if item.startswith('block-'):
                        group = item.replace('block-','')
                        groups.add(group)
                    elif item.startswith("blocktarget-"):
                        group = item.replace('blocktarget-','')
                        groups.add(group)
                    elif item.startswith('color-assigner-machine-'):
                        group = item.replace('color-assigner-machine-','')
                        groups.add(group)
                    elif item.startswith('gate-'):
                        group = item.replace('gate-','')
                        groups.add(group)

            for group in groups:
                if group != 'colorless':  # already defined in domain
                    print(f' bgroup_{group} - block_group')

        elif '<!--MAPGOALS-->' in line:
            maps = data
            chart = maps['chart']
            tiles = maps['tile_types']

            for h in range(len(chart)):
                for w in range(len(chart[h])):
                    cur_tile = chart[h][w]
                    cur_tile = tiles[cur_tile]
                    if 'end' in cur_tile:
                        print(f'  (at t{w}_{h})  ;; This is the tile that the agent should end on')
                    for tag in cur_tile:
                        if tag.startswith('blocktarget-'):
                            group = tag.replace('blocktarget-','')
                            print(f'  (block_at t{w}_{h} bgroup_{group})')

        elif '<!--include-->' in line:
            file_to_include = line.split(';')[-1]
            emit_template(open(file_to_include).read())

        else:
            print(line)

emit_template(template)