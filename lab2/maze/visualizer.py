import pygame
import json
import colorsys
import hashlib
import re

from utils import get_item_color

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
        self.fps = 1
    
    def present_frame(self, frame: pygame.Surface, do_append=True):
        if self.screen is None:
            self.screen = pygame.display.set_mode((frame.get_width(), frame.get_height()))
        if do_append:
            self.frames.append(frame.copy())
        self.screen.blit(frame, (0,0))
        pygame.display.flip()
        self.clock.tick(self.fps)
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

class FilePresenter(Presenter):
    def __init__(self, path: str):
        self.path = path
        self.frame = 0
    def present_frame(self, frame):
        pygame.image.save(frame, self.path + f'/frame{self.frame:04d}.png')
        self.frame += 1
    def present_end(self):
        pass


class Renderer:
    TILE_SIZE = 64
    def __init__(self, map_data, plan, presenter):
        self.presenter = presenter
        self.presenter.fps = map_data.get('fps', 1)
        self.map_data = map_data
        self.plan = plan.splitlines()
        self.initialize_map()
        self.initialize_state()
        self.initialize_my_surface()
        # Images from the Google Noto Color Emoji font, licensed under the SIL Open Font License
        self.robot_graphic = pygame.image.load('robot_1f916.png')
        self.robot_graphic = pygame.transform.scale(self.robot_graphic, (self.TILE_SIZE, self.TILE_SIZE))
        self.robot_outline = pygame.image.load('robot_outline.png')
        self.robot_outline = pygame.transform.scale(self.robot_outline, (self.TILE_SIZE, self.TILE_SIZE))

        self.color_remover_machine_graphic = pygame.image.load('gear_2699-fe0f.png')
        self.color_remover_machine_graphic = pygame.transform.scale(self.color_remover_machine_graphic, (self.TILE_SIZE, self.TILE_SIZE))

    def initialize_map(self):
        self.chart = []
        for row in self.map_data['chart']:
            chart_row = []
            for cell_type in row:
                cell_tags = self.map_data['tile_types'][cell_type]
                new_cell_tags = []
                for tag in cell_tags:
                    new_cell_tags.append(tag.lower())
                chart_row.append(new_cell_tags)
            self.chart.append(chart_row)
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
        self.painting_block = None

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
                        color = get_item_color('teleport', teleport_group, self.map_data)
                        # Draw an 2:1 ellipse in the middle of the tile
                        ellipse_rect = pygame.Rect(w * self.TILE_SIZE, h * self.TILE_SIZE,
                            self.TILE_SIZE, self.TILE_SIZE)
                        ellipse_rect.inflate_ip(-self.TILE_SIZE // 2, -self.TILE_SIZE // 4)
                        pygame.draw.ellipse(self.surface, color, ellipse_rect)

    def draw_blocks_on_ground(self):
        for h in range(self.height):
            for w in range(self.width):
                for tag in self.chart[h][w]:
                    if tag.startswith('block-'):
                        block = tag.replace('block-', '')
                        color = get_item_color('block', block, self.map_data)
                        rect = pygame.Rect(w * self.TILE_SIZE, h * self.TILE_SIZE, self.TILE_SIZE, self.TILE_SIZE)
                        rect.inflate_ip(-self.TILE_SIZE // 4, -self.TILE_SIZE // 4)
                        pygame.draw.rect(self.surface, color, rect)
                    if tag.startswith('blocktarget-'):
                        block = tag.replace('blocktarget-', '')
                        color = get_item_color('block', block, self.map_data)
                        rect = pygame.Rect(w * self.TILE_SIZE, h * self.TILE_SIZE, self.TILE_SIZE, self.TILE_SIZE)
                        rect.inflate_ip(-self.TILE_SIZE // 4, -self.TILE_SIZE // 4)
                        rect.inflate_ip(+self.TILE_SIZE // 8, +self.TILE_SIZE // 8)
                        pygame.draw.rect(self.surface, color, rect, 2)
                    if tag == 'end':
                        self.surface.blit(self.robot_outline, (w * self.TILE_SIZE, h * self.TILE_SIZE))
                    if tag == 'color-remover-machine':
                        self.surface.blit(self.color_remover_machine_graphic, (w * self.TILE_SIZE, h * self.TILE_SIZE))


    def draw_robot(self):
        w,h = self.robot_location
        if not self.teleporting:
            # If not teleporting, draw the robot at its location
            self.surface.blit(self.robot_graphic, (w * self.TILE_SIZE, h * self.TILE_SIZE))
        else:
            # If teleporting, draw half of the robot at its location and half at the teleporter
            tw,th = self.teleporting
            self.surface.blit(self.robot_graphic, (w * self.TILE_SIZE, h * self.TILE_SIZE), (0, 0, self.TILE_SIZE // 2, self.TILE_SIZE))
            self.surface.blit(self.robot_graphic, (tw * self.TILE_SIZE + self.TILE_SIZE//2, th * self.TILE_SIZE), (self.TILE_SIZE // 2, 0, self.TILE_SIZE // 2, self.TILE_SIZE))

            # Determine the color of the teleporter
            teleport_group = None
            for tag in self.chart[th][tw]:
                if tag.startswith('teleport-group-'):
                    teleport_group = tag.replace('teleport-group-', '')
                    break
            color = get_item_color('teleport', teleport_group, self.map_data)

            # Also draw a line between the two locations
            pygame.draw.line(self.surface, color,
                (w * self.TILE_SIZE + self.TILE_SIZE // 2, h * self.TILE_SIZE + self.TILE_SIZE // 2),
                (tw * self.TILE_SIZE + self.TILE_SIZE // 2, th * self.TILE_SIZE + self.TILE_SIZE // 2), 2)

            # After teleporting, the teleport state is reset, and the location is updated
            self.teleporting = None
            self.robot_location = (tw,th)


        if self.carrying_item:
            type, item = self.carrying_item
            if type == 'teleporter':
                # If the robot is holding a teleporter, draw a small version of it on top of the robot
                color = get_item_color('teleport', item, self.map_data)
                ellipse_rect = pygame.Rect(w * self.TILE_SIZE, h * self.TILE_SIZE,
                    self.TILE_SIZE, self.TILE_SIZE)
                ellipse_rect.inflate_ip(-self.TILE_SIZE // 2, -self.TILE_SIZE // 4)
                ellipse_rect.inflate_ip(-self.TILE_SIZE // 4, -self.TILE_SIZE // 8)
                pygame.draw.ellipse(self.surface, color, ellipse_rect)

            elif type == 'block' and not self.painting_block:
                # If the robot is holding a block, draw a diamond on top of the robot
                color = get_item_color('block', item, self.map_data)
                pygame.draw.polygon(self.surface, color, [
                    (w * self.TILE_SIZE + self.TILE_SIZE // 2, h * self.TILE_SIZE + self.TILE_SIZE // 4),
                    (w * self.TILE_SIZE + self.TILE_SIZE // 4, h * self.TILE_SIZE + self.TILE_SIZE // 2),
                    (w * self.TILE_SIZE + self.TILE_SIZE // 2, h * self.TILE_SIZE + self.TILE_SIZE // 4 * 3),
                    (w * self.TILE_SIZE + self.TILE_SIZE // 4 * 3, h * self.TILE_SIZE + self.TILE_SIZE // 2),
                ])
            elif type == 'block' and self.painting_block:
                # If the robot is holding a block and currently painting a block,
                # draw the diamond as two triangles next to each other:
                # the left shows the old color, the right shows the new color
                color = get_item_color('block', item, self.map_data)
                new_color = get_item_color('block', self.painting_block, self.map_data)
                pygame.draw.polygon(self.surface, color, [
                    (w * self.TILE_SIZE + self.TILE_SIZE // 2, h * self.TILE_SIZE + self.TILE_SIZE // 4),
                    (w * self.TILE_SIZE + self.TILE_SIZE // 4, h * self.TILE_SIZE + self.TILE_SIZE // 2),
                    (w * self.TILE_SIZE + self.TILE_SIZE // 2, h * self.TILE_SIZE + self.TILE_SIZE // 4 * 3),
                ])
                pygame.draw.polygon(self.surface, new_color, [
                    (w * self.TILE_SIZE + self.TILE_SIZE // 2, h * self.TILE_SIZE + self.TILE_SIZE // 4),
                    (w * self.TILE_SIZE + self.TILE_SIZE // 4 * 3, h * self.TILE_SIZE + self.TILE_SIZE // 2),
                    (w * self.TILE_SIZE + self.TILE_SIZE // 2, h * self.TILE_SIZE + self.TILE_SIZE // 4 * 3),
                ])

                # After painting, the block being held becomes the new color
                self.carrying_item = ('block', self.painting_block)
                self.painting_block = None



    def execute_line(self, line):
        print(line)
        # (move t0_7 t1_7) -- Move robot from tile 0,7 to tile 1,7
        if match := re.match(r'\(move t(\d+)_(\d+) t(\d+)_(\d+)\)', line):
            self.move_robot(int(match.group(1)), int(match.group(2)), int(match.group(3)), int(match.group(4)))
        # (use_teleporter t4_7 t4_0 tgroup_a) -- Use teleporter in tile 4,7 to teleport to tile 4,0 in tgroup_a
        elif match := re.match(r'\(use_teleporter t(\d+)_(\d+) t(\d+)_(\d+) tgroup_(.+)\)', line):
            self.use_teleporter(int(match.group(1)), int(match.group(2)), int(match.group(3)), int(match.group(4)), match.group(5))
        # (pick_up_block t0_0 bgroup_a) -- Pixk up block in tile 0,0 from group bgroup_a
        elif match := re.match(r'\(pick_up_block t(\d+)_(\d+) bgroup_(.+)\)', line):
            self.pick_up_block(int(match.group(1)), int(match.group(2)), match.group(3))
        # (drop_block t7_6 bgroup_a) -- Drop block in tile 7,6 in group bgroup_a
        elif match := re.match(r'\(drop_block t(\d+)_(\d+) bgroup_(.+)\)', line):
            self.drop_block(int(match.group(1)), int(match.group(2)), match.group(3))
        # (pick_up_tp t6_0 tgroup_1) -- Pick up teleporter in tile 6,0 from group tgroup_1
        elif match := re.match(r'\(pick_up_tp t(\d+)_(\d+) tgroup_(.+)\)', line):
            self.pick_up_teleporter(int(match.group(1)), int(match.group(2)), match.group(3))
        # (drop_tp t6_0 tgroup_1) -- Drop teleporter in tile 6,0 in group tgroup_1
        elif match := re.match(r'\(drop_tp t(\d+)_(\d+) tgroup_(.+)\)', line):
            self.drop_teleporter(int(match.group(1)), int(match.group(2)), match.group(3))
        # (use_color_remover_machine t0_0 bgroup_a) -- Use color remover machine in tile 0,0 to remove color from block in group bgroup_a
        elif match := re.match(r'\(use_color_remover_machine t(\d+)_(\d+) bgroup_(.+)\)', line):
            self.use_color_remover_machine(int(match.group(1)), int(match.group(2)), match.group(3))
        else:
            print('Unknown line:', line)

    
    def move_robot(self, from_x, from_y, to_x, to_y):
        if self.robot_location == (from_x, from_y):
            self.robot_location = (to_x, to_y)
    
    def use_teleporter(self, from_x, from_y, to_x, to_y, group):
        self.teleporting = (to_x, to_y)
    
    def pick_up_block(self, x, y, group):
        print(x, y, self.robot_location, 'pick up')
        if self.robot_location == (x, y):
            self.carrying_item = ('block', group)
            print('Now carrying', self.carrying_item)
            self.chart[y][x].remove(f'block-{group}')
    
    def drop_block(self, x, y, group):
        print(x, y, self.robot_location, 'drop')
        if self.robot_location == (x, y):
            print('No longer carrying', self.carrying_item)
            self.carrying_item = None
            self.chart[y][x].append(f'block-{group}')

    def pick_up_teleporter(self, x, y, group):
        if self.robot_location == (x, y):
            self.carrying_item = ('teleporter', group)
            self.chart[y][x].remove(f'teleport-group-{group}')
    
    def drop_teleporter(self, x, y, group):
        if self.robot_location == (x, y):
            self.carrying_item = None
            self.chart[y][x].append(f'teleport-group-{group}')
    
    def use_color_remover_machine(self, x, y, group):
        if self.robot_location == (x, y):
            self.painting_block = 'colorless'

if __name__ == '__main__':
    map = json.load(open('current_map.json'))
    plan = open('sas_plan').read()
    presenter = FilePresenter('output')
    #presenter = ScreenPresenter()
    renderer = Renderer(map, plan, presenter)
    renderer.run()
