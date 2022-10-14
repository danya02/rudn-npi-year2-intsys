import pygame

pygame.init()

font_names = pygame.font.get_fonts()
fonts = {name: pygame.font.SysFont(name, 32) for name in font_names}

def check_font(font, font_name, chars):
    render = font.render(chars, True, (255,255,255))
    display = pygame.display.set_mode((render.get_width(), render.get_height()))
    accept_state = 0
    pygame.display.set_caption(font_name + ": press Enter to accept, Esc reject")
    clock = pygame.time.Clock()
    while True:
        clock.tick(15)
        if accept_state == 0:
            color = (0,0,0)
        elif accept_state == 1:
            color = (0,255,0)
        elif accept_state == -1:
            color = (255,0,0)
        display.fill(color)
        display.blit(render, (0,0))
        pygame.display.flip()

        for event in pygame.event.get():
            if event.type == pygame.KEYDOWN:
                if event.key == pygame.K_RETURN:
                    accept_state += 1
                    if accept_state >= 2:
                        return True
                elif event.key == pygame.K_ESCAPE:
                    accept_state -= 1
                    if accept_state <= -2:
                        return False

usable_fonts = []
for font_name in fonts:
    font = fonts[font_name]
    if check_font(font, font_name, "1234567890"):
        usable_fonts.append(font_name)

print("Usable fonts:")
for font in usable_fonts:
    print(font)

with open('usable-fonts.txt', 'w') as f:
    for font in usable_fonts:
        f.write(font + '\n')
