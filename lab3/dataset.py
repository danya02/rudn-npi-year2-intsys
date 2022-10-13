from typing import Dict, List
import pygame
from extern_calc import CELL_SIZE

pygame.init()
symbols = "123"

def load_fonts() -> List[pygame.font.Font]:
    fonts = pygame.font.get_fonts()
    fonts = [pygame.font.SysFont(font, CELL_SIZE) for font in fonts]
    return fonts

def render_symbol_in_fonts(fonts: List[pygame.font.Font], symbol: str) -> List[pygame.Surface]:
    surfaces = [font.render(symbol, True, (255,255,255)) for font in fonts]
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
