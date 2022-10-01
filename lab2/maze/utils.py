import hashlib
import pygame
import colorsys

def get_item_hue(type: str, item: str, context: dict=None) -> float:
    it_hash = int(hashlib.md5((type + '-' + item).encode('utf-8')).hexdigest(), 16)
    it_hue = it_hash % 1000 / 1000
    return it_hue

def get_item_color(type: str, item: str, context: dict=None) -> pygame.Color:
    if f'{type}-{item}'.lower() in context.get('colors', {}):
        return pygame.Color(context['colors'][f'{type}-{item}'.lower()])

    if (type, item) in [('block', 'colorless'), ('teleport', 'unpaired')]:
        return pygame.Color(255, 255, 255)

    it_hue = get_item_hue(type, item)
    it_color = colorsys.hls_to_rgb(it_hue, 0.5, 1.0)
    color = pygame.Color(*[int(c * 255) for c in it_color])
    return color
