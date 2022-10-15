from operator import inv
from tkinter.tix import CELL
import pygame
import pygame.gfxdraw
from extern_calc import *
import dataset
import time

SURF_TARGET_SIZE = 100

class Window:
    def __init__(self):
        pygame.init()
        self.display = pygame.display.set_mode((800, 600))
        self.clock = pygame.time.Clock()
        self.font = pygame.font.SysFont("Arial", 16)
        self.running = True

        self.dataset = None
        self.kernels = dict()
        self.inv_covariances = dict()

        self.drawing_surface = pygame.Surface((CELL_SIZE, CELL_SIZE))
        self.drawing_surface.fill((0,0,0))
        self.drawing_surface_scaled = None
        self.drawing_surface_rect = pygame.Rect(0, 0, SURF_TARGET_SIZE, SURF_TARGET_SIZE)
        # place the drawing surface near the top left corner
        self.drawing_surface_rect.center = (SURF_TARGET_SIZE, SURF_TARGET_SIZE)

        self.current_cursor_position = None
        self.current_cursor_size = 3

        self.latest_predictions = []
        self.invalidate_predictions = True
        self.latest_prediction_duration = 0

    
    def write_big_message(self, text):
        render = self.font.render(text, True, (255,255,255))
        box = render.get_rect()
        box.center = self.display.get_rect().center
        self.display.fill((0,0,0))
        self.display.blit(render, box)
        pygame.display.flip()

    def construct_dataset(self, symbols='0123456789'):
        self.write_big_message("Constructing dataset...")
        self.dataset = dataset.construct_dataset(dataset.load_fonts(), symbols)
        
        self.kernels = dict()
        for symbol in self.dataset:
            self.write_big_message("Computing kernel for " + symbol)
            kernel = extern_class_into_kernel(self.dataset[symbol])
            self.kernels[symbol] = kernel
        
        self.inv_covariances = dict()
        for symbol in self.dataset:
            self.write_big_message("Computing inverse covariance for " + symbol)
            covariance = extern_class_into_covariance(self.dataset[symbol], self.kernels[symbol])
            add_identity(covariance)
            extern_class_into_inverse(covariance)
            self.inv_covariances[symbol] = covariance
        
        self.write_big_message("Done constructing dataset")
    
    def run_predictions(self):
        self.invalidate_predictions = False
        self.latest_predictions.clear()
        predict_start = time.perf_counter()

        self.drawing_surface_scaled = pygame.transform.scale(self.drawing_surface, (SURF_TARGET_SIZE, SURF_TARGET_SIZE))
        

        for symbol_class in self.dataset:
            inv_covariance = self.inv_covariances[symbol_class]
            for data_point in [self.kernels[symbol_class]]:
                dist = extern_mahalanobis_distance(self.drawing_surface, surface_to_vector(data_point), inv_covariance)[0]
                if not isinstance(data_point, pygame.Surface):
                    data_point = vector_to_surface(data_point)
                obj = pygame.transform.scale(data_point, (SURF_TARGET_SIZE, SURF_TARGET_SIZE))
                self.latest_predictions.append((dist, obj, symbol_class))
        self.latest_predictions.sort(key=lambda x: x[0])

        self.latest_prediction_duration = time.perf_counter() - predict_start


    def draw(self):
        self.display.fill((0,0,0))
        if self.invalidate_predictions:
            self.run_predictions()

        # draw the drawing surface
        self.display.blit(self.drawing_surface_scaled, self.drawing_surface_rect)
        # draw the border around the drawing surface
        pygame.draw.rect(self.display, (255,255,255), self.drawing_surface_rect, 1)
        # draw the help text below the drawing surface
        render = self.font.render("Esc clears, M1 draw, M2 erases, Scroll to change size", True, (255,255,255))
        self.display.blit(render, (0, self.drawing_surface_rect.bottom + 10))
        # draw the current cursor position
        if self.current_cursor_position:
            #relative_cursor_position = (self.current_cursor_position[0] - self.drawing_surface_rect.left, self.current_cursor_position[1] - self.drawing_surface_rect.top)
            cursor_scale = self.drawing_surface_rect.width / self.drawing_surface.get_width()

            pygame.draw.circle(self.display, (64, 64, 64), self.current_cursor_position, self.current_cursor_size*cursor_scale, 1)
        
        # draw the predictions
        for i, (dist, kernel, symbol_class) in enumerate(self.latest_predictions[:10]):
            render = self.font.render(f"{symbol_class}: {dist}", True, (255,255,255))
            rect = kernel.get_rect()
            rect.topleft = (self.drawing_surface_rect.right + 200, i * (rect.height + 20) + 20)
            self.display.blit(kernel, rect)
            self.display.blit(render, rect.move(rect.width+20, rect.height//2))
            pygame.draw.rect(self.display, (255,255,255), rect, 1)
        
        # draw the prediction time in the bottom left corner
        render = self.font.render(f"Prediction time: {self.latest_prediction_duration} seconds", True, (255,255,255))
        rect = render.get_rect()
        rect.bottomleft = self.display.get_rect().bottomleft
        self.display.blit(render, rect)

    def handle_events(self):
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                self.running = False
            elif event.type == pygame.KEYDOWN:
                if event.key == pygame.K_ESCAPE:
                    self.drawing_surface.fill((0,0,0))
                    self.invalidate_predictions = True
            elif event.type == pygame.MOUSEBUTTONDOWN:
                if event.button == 4:
                    self.current_cursor_size = min(16, self.current_cursor_size + 1)
                elif event.button == 5:
                    self.current_cursor_size = max(1, self.current_cursor_size - 1)
            elif event.type == pygame.MOUSEMOTION:
                self.current_cursor_position = event.pos
                # get the relative position inside the drawing rect
                relative_cursor_position = (self.current_cursor_position[0] - self.drawing_surface_rect.left, self.current_cursor_position[1] - self.drawing_surface_rect.top)
                # scale the relative position to the drawing surface size
                relative_cursor_position = (relative_cursor_position[0] * CELL_SIZE // self.drawing_surface_rect.width, relative_cursor_position[1] * CELL_SIZE // self.drawing_surface_rect.height)
                if pygame.mouse.get_pressed()[0]:  # left mouse button is pressed: draw on the drawing surface
                    if self.current_cursor_size == 1:
                        self.drawing_surface.set_at(relative_cursor_position, (255,255,255))
                    else:
                        pygame.gfxdraw.filled_circle(self.drawing_surface, *relative_cursor_position, max(self.current_cursor_size-1, 1), (255,255,255))
                        pygame.gfxdraw.aacircle(self.drawing_surface, *relative_cursor_position, self.current_cursor_size, (255,255,255))
                    self.invalidate_predictions = True

                elif pygame.mouse.get_pressed()[2]:  # right mouse button is pressed: erase on the drawing surface
                    if self.current_cursor_size == 1:
                        self.drawing_surface.set_at(relative_cursor_position, (0,0,0))
                    else:
                        pygame.gfxdraw.filled_circle(self.drawing_surface, *relative_cursor_position, max(self.current_cursor_size-1, 1), (0,0,0))
                        pygame.gfxdraw.aacircle(self.drawing_surface, *relative_cursor_position, self.current_cursor_size, (0,0,0))
                    self.invalidate_predictions = True

    def run(self, symbols):
        self.construct_dataset(symbols)
        while self.running:
            self.handle_events()
            self.draw()
            pygame.display.flip()
            self.clock.tick(30)