from tetris_config import *
print("(define (problem tetris_problem)")
print("(:domain tetris)")

# List all tile objects
print("(:objects")
for h in range(HEIGHT):
    for w in range(WIDTH):
        print(f"  tile_{h}_{w} - tile")

print(")")

# Start listing the initial state
print("(:init")

# Each tile between 1 and WIDTH has a tile to the left
for h in range(HEIGHT):
    for w in range(1, WIDTH):
        print(f"  (left_of tile_{h}_{w} tile_{h}_{w-1})")

# Each tile between 0 and WIDTH-1 has a tile to the right
for h in range(HEIGHT):
    for w in range(WIDTH-1):
        print(f"  (right_of tile_{h}_{w} tile_{h}_{w+1})")

# Each tile between 1 and HEIGHT has a tile below
for h in range(1, HEIGHT):
    for w in range(WIDTH):
        print(f"  (below tile_{h}_{w} tile_{h-1}_{w})")

# Each tile between 0 and HEIGHT-1 has a tile above
for h in range(HEIGHT-1):
    for w in range(WIDTH):
        print(f"  (above tile_{h}_{w} tile_{h+1}_{w})")

# Each tile on row 0 is on the ground
for w in range(WIDTH):
    print(f"  (on_ground tile_0_{w})")

# Each tile on column 0 is on the left wall
# Each tile on column WIDTH-1 is on the right wall
for h in range(HEIGHT):
    print(f"  (on_left_wall tile_{h}_0)")
    print(f"  (on_right_wall tile_{h}_{WIDTH-1})")

# The tile at row HEIGHT-1 and column WIDTH//2 is the spawn tile
print(f"  (spawn_tile tile_{HEIGHT-1}_{WIDTH//2})")



# Initially all tiles are empty
for h in range(HEIGHT):
    for w in range(WIDTH):
        print(f"  (color tile_{h}_{w} cempty)")

print(')')
print('(:goal (and')
for h in range(HEIGHT):
    for w in range(WIDTH):
        print(f"  (color tile_{h}_{w} c{int(GOAL[h][w]) or 'empty'})")

print('))')
print(')')
