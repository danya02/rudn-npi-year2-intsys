import pygame
import json
import colorsys
import hashlib
import re

class Presenter:
    def present_frame(self, frame):
        raise NotImplementedError
    
    def present_end(self):
        raise NotImplementedError

class ScreenPresenter(Presenter):
    def __init__(self):
        self.screen = None
        self.frames = []
        self.clock = pygame.time.Clock()
    
    def present_frame(self, frame: pygame.Surface, do_append=True):
        if self.screen is None:
            self.screen = pygame.display.set_mode((frame.get_width(), frame.get_height()))
        if do_append:
            self.frames.append(frame.copy())
        self.screen.blit(frame, (0,0))
        pygame.display.flip()
        self.clock.tick(5)
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                pygame.quit()
                exit()
    
    def present_end(self):
        while True:
            self.screen.fill('black')
            pygame.display.flip()
            self.clock.tick(1)
            for frame in self.frames:
                self.present_frame(frame, do_append=False)

class Renderer:
    TILE_SIZE = 64
    def __init__(self, map_data, plan, presenter):
        self.presenter = presenter
        self.map_data = map_data
        self.plan = plan.splitlines()
        self.initialize_map()
        self.initialize_state()
        self.initialize_my_surface()
    
    def initialize_map(self):
        self.chart = []
        for row in self.map_data['chart']:
            self.chart.append([self.map_data['tile_types'][tile] for tile in row])
        self.robot_location = None
        for h in range(len(self.chart)):
            for w in range(len(self.chart[h])):
                if 'start' in self.chart[h][w]:
                    self.robot_location = (w,h)
                    break
        self.width = len(self.chart[0])
        self.height = len(self.chart)
    
    def initialize_state(self):
        self.carrying_item = None
        self.teleporting = None

    def initialize_my_surface(self):
        self.surface = pygame.Surface((self.width * self.TILE_SIZE, self.height * self.TILE_SIZE))
        self.surface.fill('black')

    def run(self):
        self.render_current_state()
        self.presenter.present_frame(self.surface)

        for line in self.plan:
            self.execute_line(line)
            self.render_current_state()
            self.presenter.present_frame(self.surface)
        self.presenter.present_end()

    def render_current_state(self):
        self.surface.fill('black')
        self.draw_grid_lines()
        self.draw_walls()
        self.draw_teleporters_on_ground()
        self.draw_blocks_on_ground()
        self.draw_robot()
        self.draw_carried_items()
    
    def draw_grid_lines(self):
        for x in range(self.width):
            pygame.draw.line(self.surface, 'white', (x * self.TILE_SIZE, 0), (x * self.TILE_SIZE, self.height * self.TILE_SIZE))
        for y in range(self.height):
            pygame.draw.line(self.surface, 'white', (0, y * self.TILE_SIZE), (self.width * self.TILE_SIZE, y * self.TILE_SIZE))
    
    def draw_walls(self):
        for h in range(self.height):
            for w in range(self.width):
                if not 'walk' in self.chart[h][w]:
                    pygame.draw.rect(self.surface, 'grey', (w * self.TILE_SIZE, h * self.TILE_SIZE, self.TILE_SIZE, self.TILE_SIZE))
    
    def draw_teleporters_on_ground(self):
        for h in range(self.height):
            for w in range(self.width):
                for tag in self.chart[h][w]:
                    if tag.startswith('teleport-group-'):
                        teleport_group = tag.replace('teleport-group-', '')
                        tg_hash = int(hashlib.md5(teleport_group.encode('utf-8')).hexdigest(), 16)
                        tg_color = colorsys.hsv_to_rgb(tg_hash % 1000 / 1000, 1, 1)
                        color = pygame.Color(*[int(c * 255) for c in tg_color])
                        # Draw an 2:1 ellipse in the middle of the tile
                        pygame.draw.ellipse(self.surface, color,
                                (w * self.TILE_SIZE + self.TILE_SIZE // 4,
                                    h * self.TILE_SIZE + self.TILE_SIZE // 8,
                                    self.TILE_SIZE // 2,
                                    self.TILE_SIZE // 4))
    
    def draw_blocks_on_ground(self):
        for h in range(self.height):
            for w in range(self.width):
                for tag in self.chart[h][w]:
                    if tag.startswith('block-'):
                        block = tag.replace('block-', '')
                        b_hash = int(hashlib.md5(block.encode('utf-8')).hexdigest(), 16)
                        b_color = colorsys.hsv_to_rgb(b_hash % 1000 / 1000, 1, 1)
                        color = pygame.Color(*[int(c * 255) for c in b_color])
                        # Draw a 1:1 rectangle in the middle of the tile
                        pygame.draw.rect(self.surface, color,
                                (w * self.TILE_SIZE + self.TILE_SIZE // 4,
                                    h * self.TILE_SIZE + self.TILE_SIZE // 4,
                                    self.TILE_SIZE // 2,
                                    self.TILE_SIZE // 2))
    
    def draw_robot(self):
        w,h = self.robot_location
        # TODO: find robot graphic
        if not self.teleporting:
            # If not teleporting, draw the robot at its location
            pygame.draw.rect(self.surface, 'red', (w * self.TILE_SIZE, h * self.TILE_SIZE, self.TILE_SIZE//8, self.TILE_SIZE//8))
        else:
            # If teleporting, draw half of the robot at its location and half at the teleporter
            tw,th = self.teleporting
            pygame.draw.rect(self.surface, 'red', (w * self.TILE_SIZE, h * self.TILE_SIZE, self.TILE_SIZE//8, self.TILE_SIZE//8))
            pygame.draw.rect(self.surface, 'red', (tw * self.TILE_SIZE, th * self.TILE_SIZE, self.TILE_SIZE//8, self.TILE_SIZE//8))

            # After teleporting, the teleport state is reset, and the location is updated
            self.teleporting = None
            self.robot_location = (tw,th)

    def draw_carried_items(self):
        if self.carrying_item is not None:
            type, item = self.carrying_item
            if type == 'block':
                b_hash = int(hashlib.md5(item.encode('utf-8')).hexdigest(), 16)
                b_color = colorsys.hsv_to_rgb(b_hash % 1000 / 1000, 1, 1)
                color = pygame.Color(*[int(c * 255) for c in b_color])
                # Draw a 1:1 rectangle in the corner of the tile
                pygame.draw.rect(self.surface, color,
                        (self.TILE_SIZE // 4,
                            self.TILE_SIZE // 4,
                            self.TILE_SIZE // 2,
                            self.TILE_SIZE // 2))
            elif type == 'teleporter':
                tg_hash = int(hashlib.md5(item.encode('utf-8')).hexdigest(), 16)
                tg_color = colorsys.hsv_to_rgb(tg_hash % 1000 / 1000, 1, 1)
                color = pygame.Color(*[int(c * 255) for c in tg_color])
                # Draw an 2:1 ellipse in the corner of the tile
                pygame.draw.ellipse(self.surface, color,
                        (self.TILE_SIZE // 4,
                            self.TILE_SIZE // 8,
                            self.TILE_SIZE // 2,
                            self.TILE_SIZE // 4))

    def execute_line(self, line):
        # (move t0_7 t1_7) -- Move robot from tile 0,7 to tile 1,7
        if match := re.match(r'\(move t(\d+)_(\d+) t(\d+)_(\d+)\)', line):
            self.move_robot(int(match.group(1)), int(match.group(2)), int(match.group(3)), int(match.group(4)))
        # (use_teleporter t4_7 t4_0 group_a) -- Use teleporter in tile 4,7 to teleport to tile 4,0 in group_a
        elif match := re.match(r'\(use_teleporter t(\d+)_(\d+) t(\d+)_(\d+) (.+)\)', line):
            self.use_teleporter(int(match.group(1)), int(match.group(2)), int(match.group(3)), int(match.group(4)), match.group(5))
        else: pass
    
    def move_robot(self, from_x, from_y, to_x, to_y):
        if self.robot_location == (from_x, from_y):
            self.robot_location = (to_x, to_y)
    
    def use_teleporter(self, from_x, from_y, to_x, to_y, group):
        self.teleporting = (to_x, to_y)

if __name__ == '__main__':
    map = json.load(open('simple_maze.json'))
    plan = open('sas_plan').read()
    presenter = ScreenPresenter()
    renderer = Renderer(map, plan, presenter)
    renderer.run()
