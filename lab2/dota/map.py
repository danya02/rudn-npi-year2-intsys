import sys
old_stdout = sys.stdout
old_stderr = sys.stderr
null = open("/dev/null","w")
sys.stderr = null
sys.stdout = null
import pygame
sys.stdout = old_stdout
sys.stderr = old_stderr

image = pygame.image.load("dota-map-data.png")

map = []

for h in range(0, image.get_height()):
    row = []
    for w in range(0, image.get_width()):
        pixel = image.get_at((w, h))
        if pixel == (255, 0, 255):
            row.append('FT')  # Fountain, teleportable
        elif pixel == (0, 0, 255):
            row.append('T')  # Teleportable
        else:
            row.append('')
    map.append(row)
