from typing import Dict, List
import pygame
from extern_calc import CELL_SIZE

pygame.init()
symbols = "123"

def load_fonts() -> List[pygame.font.Font]:
    fonts = pygame.font.get_fonts()
    usable_fonts = [i.strip() for i in open('/home/danya/Documents/university/rudn-npi-year2-intsys/lab3/usable-fonts.txt').read().splitlines()]
    fonts = [pygame.font.SysFont(font, CELL_SIZE) for font in fonts if font in usable_fonts]
    return fonts

def render_symbol_in_fonts(fonts: List[pygame.font.Font], symbol: str) -> List[pygame.Surface]:
    surfaces = [font.render(symbol, True, (255,255,255)) for font in fonts]
    if False:  # This doesn't seem to work, but this should be used to make sure the symbols are in the correct places
        metrics = [font.metrics(symbol) for font in fonts]
        # Crop each symbol to its bounding box (which is provided by (min x offset, max x offset, min y offset, max y offset, advance) values of the metrics)
        print(metrics)
        bboxes = [pygame.Rect(m[0][0], m[0][1], m[0][2]-m[0][0], m[0][3]-m[0][1]) for m in metrics]
        for box, surf in zip(bboxes, surfaces):
            box.clamp_ip(surf.get_rect())
        surfaces = [surface.subsurface(bbox) for surface, bbox in zip(surfaces, bboxes)]
    # Resize each symbol to CELL_SIZE x CELL_SIZE
    surfaces = [pygame.transform.smoothscale(surface, (CELL_SIZE, CELL_SIZE)) for surface in surfaces]
    backgrounds = [pygame.Surface((CELL_SIZE, CELL_SIZE)) for _ in range(len(surfaces))]
    for back, surf in zip(backgrounds, surfaces):
        back.fill((0,0,0))
        back.blit(surf, (0,0))
    return backgrounds


def construct_dataset(fonts: List[pygame.font.Font], symbols: str) -> Dict[str, List[pygame.Surface]]:
    dataset = {}
    for symbol in symbols:
        surfaces = render_symbol_in_fonts(fonts, symbol)
        dataset[symbol] = surfaces
    return dataset
