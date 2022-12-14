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

class Null: pass

class ScreenPresenter(Presenter):
    def __init__(self, step_mode='auto', loop=True):
        self.screen = None
        self.frames = []
        self.clock = pygame.time.Clock()
        self.fps = 1
        self.step_mode = step_mode
        self.loop = loop
        self.skipping_all = False
    
    def present_frame(self, frame: pygame.Surface, do_append=True):
        if self.skipping_all: return
        if self.screen is None:
            self.screen = pygame.display.set_mode((frame.get_width(), frame.get_height()))
        if do_append:
            self.frames.append(frame.copy())
        self.screen.blit(frame, (0,0))
        pygame.display.flip()
        it = True
        while it or self.step_mode != 'auto':
            it = False
            self.clock.tick(self.fps)

            for event in pygame.event.get():
                if event.type == pygame.QUIT:
                    pygame.quit()
                    exit()
                if event.type == pygame.KEYDOWN:
                    if event.key == pygame.K_ESCAPE:
                        self.skipping_all = True
                    if self.step_mode != 'auto':
                        return
    
    def present_end(self):
        while self.loop:
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
        self.robot_states = {}
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

        self.color_assigner_machine_graphic = pygame.image.load('paintbrush_1f58c-fe0f.png')
        # make the image white
        self.color_assigner_machine_graphic.fill((255,255,255,0), special_flags=pygame.BLEND_RGBA_MAX)
        self.color_assigner_machine_graphic = pygame.transform.scale(self.color_assigner_machine_graphic, (self.TILE_SIZE, self.TILE_SIZE))
        self.color_assigner_machine_cache = dict()

        self.teleporter_unpairer_graphic = pygame.image.load('hammer-and-pick_2692-fe0f.png')
        self.teleporter_unpairer_graphic = pygame.transform.scale(self.teleporter_unpairer_graphic, (self.TILE_SIZE, self.TILE_SIZE))

        self.teleporter_pairer_graphic = pygame.image.load('link_1f517.png')
        # make the image white
        self.teleporter_pairer_graphic.fill((255,255,255,0), special_flags=pygame.BLEND_RGBA_MAX)
        self.teleporter_pairer_graphic = pygame.transform.scale(self.teleporter_pairer_graphic, (self.TILE_SIZE, self.TILE_SIZE))
        self.teleporter_pairer_cache = dict()

        # Lock icon from Twemoji, licensed under MIT
        lock_graphic = pygame.image.load('locked_1f512.png')
        # invert the image: make a hole in a white surface
        lock_graphic.fill((255,255,255,0), special_flags=pygame.BLEND_RGBA_MAX) # now it is a white image on a transparent white background
        #self.locked_graphic = pygame.Surface((self.TILE_SIZE, self.TILE_SIZE), pygame.SRCALPHA)
        #self.locked_graphic.fill((255,255,255,255))  # this is a full white image
        #self.locked_graphic.blit(lock_graphic, (0,0), special_flags=pygame.BLEND_RGBA_SUB)  # this subtracts the image from the background
        self.locked_graphic = pygame.transform.scale(lock_graphic, (self.TILE_SIZE, self.TILE_SIZE))
        self.locked_graphic_cache = dict()


    def get_color_assigner_machine_by_color(self, color: pygame.Color) -> pygame.Surface:
        color = (color.r, color.g, color.b)
        if color not in self.color_assigner_machine_cache:
            new_image = self.color_assigner_machine_graphic.copy()
            new_image.fill(color, special_flags=pygame.BLEND_RGBA_MULT)
            self.color_assigner_machine_cache[color] = new_image
        return self.color_assigner_machine_cache[color]

    def get_teleporter_pairer_by_color(self, color: pygame.Color) -> pygame.Surface:
        color = (color.r, color.g, color.b)
        if color not in self.teleporter_pairer_cache:
            new_image = self.teleporter_pairer_graphic.copy()
            new_image.fill(color, special_flags=pygame.BLEND_RGBA_MULT)
            self.teleporter_pairer_cache[color] = new_image
        return self.teleporter_pairer_cache[color]
    
    def get_gate_by_color(self, color: pygame.Color) -> pygame.Surface:
        color = (color.r, color.g, color.b)
        if color not in self.locked_graphic_cache:
            new_image = self.locked_graphic.copy()
            new_image.fill(color, special_flags=pygame.BLEND_RGBA_MULT)
            self.locked_graphic_cache[color] = new_image
        return self.locked_graphic_cache[color]

    def initialize_map(self):
        self.chart = []
        self.robots = []
        for row in self.map_data['chart']:
            chart_row = []
            for cell_type in row:
                cell_tags = self.map_data['tile_types'][cell_type]
                new_cell_tags = []
                for tag in cell_tags:
                    new_cell_tags.append(tag.lower())
                chart_row.append(new_cell_tags)
            self.chart.append(chart_row)

        for h in range(len(self.chart)):
            for w in range(len(self.chart[h])):
                for tag in self.chart[h][w]:
                    if tag.startswith('start-'):
                        robot_name = tag.replace('start-', '')
                        self.robots.append(robot_name)
                        print(robot_name, w, h)

                        self.robot_states[robot_name] = Null()
                        self.robot_states[robot_name].location = (w, h)

        self.width = len(self.chart[0])
        self.height = len(self.chart)
    
    def initialize_state(self):
        self.active_robot = None
        print(self.robot_states)
        for robot in self.robots:
            self.robot_states[robot].carrying_item = None
            self.robot_states[robot].teleporting = None
            self.robot_states[robot].painting_block = None
            self.robot_states[robot].painting_teleporter = None
            self.robot_states[robot].unlocking_gate = None

    @property
    def robot_location(self):
        return self.robot_states[self.active_robot].location
    
    @robot_location.setter
    def robot_location(self, value):
        self.robot_states[self.active_robot].location = value
    
    @property
    def carrying_item(self):
        return self.robot_states[self.active_robot].carrying_item
    
    @carrying_item.setter
    def carrying_item(self, value):
        self.robot_states[self.active_robot].carrying_item = value

    @property
    def teleporting(self):
        return self.robot_states[self.active_robot].teleporting

    @teleporting.setter
    def teleporting(self, value):
        self.robot_states[self.active_robot].teleporting = value

    @property
    def painting_block(self):
        return self.robot_states[self.active_robot].painting_block

    @painting_block.setter
    def painting_block(self, value):
        self.robot_states[self.active_robot].painting_block = value

    @property
    def painting_teleporter(self):
        return self.robot_states[self.active_robot].painting_teleporter

    @painting_teleporter.setter
    def painting_teleporter(self, value):
        self.robot_states[self.active_robot].painting_teleporter = value

    @property
    def unlocking_gate(self):
        return self.robot_states[self.active_robot].unlocking_gate

    @unlocking_gate.setter
    def unlocking_gate(self, value):
        self.robot_states[self.active_robot].unlocking_gate = value

    
    def switch_context(self, robot):
        print('switching context to', robot)
        self.active_robot = robot.replace('robot_', '')


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
                        pygame.draw.ellipse(self.surface, color, ellipse_rect, 0 if teleport_group != 'unpaired' else 2)

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
                    if tag.startswith('end-'):
                        self.surface.blit(self.robot_outline, (w * self.TILE_SIZE, h * self.TILE_SIZE))
                    if tag == 'color-remover-machine':
                        self.surface.blit(self.color_remover_machine_graphic, (w * self.TILE_SIZE, h * self.TILE_SIZE))
                    if tag.startswith('color-assigner-machine-'):
                        color = tag.replace('color-assigner-machine-', '')
                        color = get_item_color('block', color, self.map_data)
                        self.surface.blit(self.get_color_assigner_machine_by_color(color), (w * self.TILE_SIZE, h * self.TILE_SIZE))
                    if tag == 'teleport-unpairer':
                        self.surface.blit(self.teleporter_unpairer_graphic, (w * self.TILE_SIZE, h * self.TILE_SIZE))
                    if tag.startswith('teleport-pairer-'):
                        color = tag.replace('teleport-pairer-', '')
                        color = get_item_color('teleport', color, self.map_data)
                        self.surface.blit(self.get_teleporter_pairer_by_color(color), (w * self.TILE_SIZE, h * self.TILE_SIZE))
                    if tag.startswith('gate-'):
                        color = tag.replace('gate-', '')
                        color = get_item_color('block', color, self.map_data)
                        self.surface.blit(self.get_gate_by_color(color), (w * self.TILE_SIZE, h * self.TILE_SIZE))


    def draw_robot(self):
        for robot_name in self.robot_states:
            self.draw_single_robot(robot_name)

    def draw_single_robot(self, robot_name):
        self.switch_context(robot_name)
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
            if type == 'teleporter' and not self.painting_teleporter:
                # If the robot is holding a teleporter, draw a small version of it on top of the robot
                color = get_item_color('teleport', item, self.map_data)
                ellipse_rect = pygame.Rect(w * self.TILE_SIZE, h * self.TILE_SIZE,
                    self.TILE_SIZE, self.TILE_SIZE)
                ellipse_rect.inflate_ip(-self.TILE_SIZE // 2, -self.TILE_SIZE // 4)
                ellipse_rect.inflate_ip(-self.TILE_SIZE // 4, -self.TILE_SIZE // 8)
                pygame.draw.ellipse(self.surface, color, ellipse_rect, 0 if item != 'unpaired' else 2)

            elif type == 'teleporter' and self.painting_teleporter:
                # If the robot is painting a teleporter, draw two copies: one with the old color and one with the new color
                ellipse_rect = pygame.Rect(w * self.TILE_SIZE, h * self.TILE_SIZE,
                    self.TILE_SIZE, self.TILE_SIZE)
                ellipse_rect.inflate_ip(-self.TILE_SIZE // 2, -self.TILE_SIZE // 4)
                ellipse_rect.inflate_ip(-self.TILE_SIZE // 4, -self.TILE_SIZE // 8)
                ellipse_rect.move_ip(-self.TILE_SIZE // 6, 0)

                old_color = get_item_color('teleport', item, self.map_data)
                pygame.draw.ellipse(self.surface, old_color, ellipse_rect, 0 if item != 'unpaired' else 2)

                new_color = get_item_color('teleport', self.painting_teleporter, self.map_data)
                pygame.draw.ellipse(self.surface, new_color, ellipse_rect.move(self.TILE_SIZE // 3, 0), 0 if self.painting_teleporter != 'unpaired' else 2)


                # After the teleporter is painted, we now hold a teleporter of the new color
                self.carrying_item = ('teleporter', self.painting_teleporter)
                self.painting_teleporter = None


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

            if self.unlocking_gate:
                gate_x, gate_y, gate_color = self.unlocking_gate
                gate_img = self.get_gate_by_color(get_item_color('block', gate_color, self.map_data))

                # Draw the gate image
                self.surface.blit(gate_img, (gate_x * self.TILE_SIZE, gate_y * self.TILE_SIZE))
                # Blank out the lower right triangle of the gate
                left_top = (gate_x * self.TILE_SIZE, gate_y * self.TILE_SIZE)
                right_top = (gate_x * self.TILE_SIZE + self.TILE_SIZE, gate_y * self.TILE_SIZE)
                left_bottom = (gate_x * self.TILE_SIZE, gate_y * self.TILE_SIZE + self.TILE_SIZE)
                right_bottom = (gate_x * self.TILE_SIZE + self.TILE_SIZE, gate_y * self.TILE_SIZE + self.TILE_SIZE)
                pygame.draw.polygon(self.surface, 'black', [
                    right_top, right_bottom, left_bottom
                ])
                # Draw the robot again
                self.surface.blit(self.robot_graphic, (w * self.TILE_SIZE, h * self.TILE_SIZE))
                # Draw the left half of the block on top of the robot
                pygame.draw.polygon(self.surface, color, [
                    (w * self.TILE_SIZE + self.TILE_SIZE // 2, h * self.TILE_SIZE + self.TILE_SIZE // 4),
                    (w * self.TILE_SIZE + self.TILE_SIZE // 4, h * self.TILE_SIZE + self.TILE_SIZE // 2),
                    (w * self.TILE_SIZE + self.TILE_SIZE // 2, h * self.TILE_SIZE + self.TILE_SIZE // 4 * 3),
                ])

                # Now the robot no longer holds the block
                self.carrying_item = None
                self.unlocking_gate = None
                self.chart[gate_y][gate_x].remove('gate-' + gate_color)
                    



    def execute_line(self, line):
        print(line)
        pygame.display.set_caption(line)
        # (move r_main t0_7 t1_7) -- Move robot main from tile 0,7 to tile 1,7
        if match := re.match(r'\(move (\w+) t(\d+)_(\d+) t(\d+)_(\d+)\)', line):
            robot_name, from_x, from_y, to_x, to_y = match.groups()
            self.move_robot(robot_name, int(from_x), int(from_y), int(to_x), int(to_y))
        # (use_teleporter r_main t4_7 t4_0 tgroup_a) -- robot main use teleporter in tile 4,7 to teleport to tile 4,0 in tgroup_a
        elif match := re.match(r'\(use_teleporter (\w+) t(\d+)_(\d+) t(\d+)_(\d+) tgroup_(\w+)\)', line):
            robot_name, from_x, from_y, to_x, to_y, teleporter_group = match.groups()
            self.use_teleporter(robot_name, int(from_x), int(from_y), int(to_x), int(to_y), teleporter_group)
        # (pick_up_block r_main t0_0 bgroup_a) -- robot main picks up block in tile 0,0 from group bgroup_a
        elif match := re.match(r'\(pick_up_block (\w+) t(\d+)_(\d+) bgroup_(\w+)\)', line):
            robot_name, x, y, block_group = match.groups()
            self.pick_up_block(robot_name, int(x), int(y), block_group)
        # (drop_block r_main t7_6 bgroup_a) -- robot main drops block in tile 7,6 in group bgroup_a
        elif match := re.match(r'\(drop_block (\w+) t(\d+)_(\d+) bgroup_(\w+)\)', line):
            robot_name, x, y, block_group = match.groups()
            self.drop_block(robot_name, int(x), int(y), block_group)
        # (pick_up_tp r_main t6_0 tgroup_1) -- robot main picks up teleporter in tile 6,0 from group tgroup_1
        elif match := re.match(r'\(pick_up_tp (\w+) t(\d+)_(\d+) tgroup_(\w+)\)', line):
            robot_name, x, y, teleporter_group = match.groups()
            self.pick_up_teleporter(robot_name, int(x), int(y), teleporter_group)
        # (drop_tp r_main t6_0 tgroup_1) -- robot main drops teleporter in tile 6,0 in group tgroup_1
        elif match := re.match(r'\(drop_tp (\w+) t(\d+)_(\d+) tgroup_(\w+)\)', line):
            robot_name, x, y, teleporter_group = match.groups()
            self.drop_teleporter(robot_name, int(x), int(y), teleporter_group)
        # (use_color_remover_machine r_main t0_0 bgroup_a) -- robot main uses color remover machine in tile 0,0 to remove color from block in group bgroup_a
        elif match := re.match(r'\(use_color_remover_machine (\w+) t(\d+)_(\d+) bgroup_(\w+)\)', line):
            robot_name, x, y, block_group = match.groups()
            self.use_color_remover_machine(robot_name, int(x), int(y), block_group)
        # (use_color_assigner_machine r_main t2_0 bgroup_p) -- robot main uses color assigner machine in tile 2,0 to assign color to block in group bgroup_p
        elif match := re.match(r'\(use_color_assigner_machine (\w+) t(\d+)_(\d+) bgroup_(\w+)\)', line):
            robot_name, x, y, block_group = match.groups()
            self.use_color_assigner_machine(robot_name, int(x), int(y), block_group)
        # (pair_tp r_main t2_2 tgroup_p) -- Pair teleporter in tile 2,2 with teleporter in group tgroup_p
        elif match := re.match(r'\(pair_tp (\w+) t(\d+)_(\d+) tgroup_(\w+)\)', line):
            robot_name, x, y, teleporter_group = match.groups()
            self.pair_teleporter(robot_name, int(x), int(y), teleporter_group)
        # (unpair_tp r_main t2_2 tgroup_p) -- Unpair teleporter in tile 2,2 from group tgroup_p
        elif match := re.match(r'\(unpair_tp (\w+) t(\d+)_(\d+) tgroup_(\w+)\)', line):
            robot_name, x, y, teleporter_group = match.groups()
            self.unpair_teleporter(robot_name, int(x), int(y), teleporter_group)
        # (unlock_gate r_main t1_0 t1_1 bgroup_p) -- Unlock gate: while standing in 1,0 unlock the gate at 1,1 using block in group bgroup_p
        elif match := re.match(r'\(unlock_gate (\w+) t(\d+)_(\d+) t(\d+)_(\d+) bgroup_(\w+)\)', line):
            robot_name, robot_x, robot_y, gate_x, gate_y, block_group = match.groups()
            self.unlock_gate(robot_name, int(robot_x), int(robot_y), int(gate_x), int(gate_y), block_group)
        else:
            print('Unknown line:', line)

    
    def move_robot(self, robot_name, from_x, from_y, to_x, to_y):
        self.switch_context(robot_name)
        if self.robot_location == (from_x, from_y):
            self.robot_location = (to_x, to_y)
            print("?????? ?? ", to_x, to_y)
    
    def use_teleporter(self, robot_name, from_x, from_y, to_x, to_y, group):
        self.switch_context(robot_name)
        self.teleporting = (to_x, to_y)
        print("???????????????????????????? ?? ", to_x, to_y, "?? ?????????????? ??????????????", group)
    
    def pick_up_block(self, robot_name, x, y, group):
        self.switch_context(robot_name)
        print(x, y, self.robot_location, 'pick up')
        if self.robot_location == (x, y):
            self.carrying_item = ('block', group)
            self.chart[y][x].remove(f'block-{group}')
            print("???????????????? ???????? ????????????", group)
    
    def drop_block(self, robot_name, x, y, group):
        self.switch_context(robot_name)
        print(x, y, self.robot_location, 'drop')
        if self.robot_location == (x, y):
            self.carrying_item = None
            self.chart[y][x].append(f'block-{group}')
            print("???????????? ???????? ????????????", group)

    def pick_up_teleporter(self, robot_name, x, y, group):
        self.switch_context(robot_name)
        if self.robot_location == (x, y):
            self.carrying_item = ('teleporter', group)
            self.chart[y][x].remove(f'teleport-group-{group}')
            print("???????????????? ???????????? ????????????", group)
    
    def drop_teleporter(self, robot_name, x, y, group):
        self.switch_context(robot_name)
        if self.robot_location == (x, y):
            self.carrying_item = None
            self.chart[y][x].append(f'teleport-group-{group}')
            print("???????????? ???????????? ????????????", group)

    def use_color_remover_machine(self, robot_name, x, y, group):
        self.switch_context(robot_name)
        if self.robot_location == (x, y):
            self.painting_block = 'colorless'
            print("???????????? ???????? ?? ?????????? ????????????", group)
    
    def use_color_assigner_machine(self, robot_name, x, y, group):
        self.switch_context(robot_name)
        if self.robot_location == (x, y):
            self.painting_block = group
            print("???????????? ???????? ????????????", group, "???? ????????")
    
    def pair_teleporter(self, robot_name, x, y, group):
        self.switch_context(robot_name)
        if self.robot_location == (x, y):
            self.painting_teleporter = group
            print("???????????????????? ???????????? ?? ????????????", group)

    def unpair_teleporter(self, robot_name, x, y, group):
        self.switch_context(robot_name)
        if self.robot_location == (x, y):
            self.painting_teleporter = 'unpaired'
            print("?????????????????? ???????????? ???? ?????? ????????????")
 
    def unlock_gate(self, robot_name, from_x, from_y, to_x, to_y, group):
        self.switch_context(robot_name)
        if self.robot_location == (from_x, from_y):
            self.unlocking_gate = (to_x, to_y, group)
            print("???????????????? ?????????? ??", to_x, to_y, "?? ?????????????? ?????????? ????????????", group)

if __name__ == '__main__':
    import os
    import sys
    if sys.argv[1] + '.json' in os.listdir('problems'):
        map_name = sys.argv[1] + '.json'
        map = json.load(open('problems/' + map_name))
        plan = open('plans/' + map_name + '.plan').read()
        presenter = FilePresenter('output')
        presenter = ScreenPresenter(loop=True)
        renderer = Renderer(map, plan, presenter)
        renderer.run()
    else:
        print('No such map')
