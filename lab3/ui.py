from operator import inv
from tkinter.tix import CELL
import pygame
from extern_calc import *
import dataset

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
        self.drawing_surface_rect = self.drawing_surface.get_rect()
        # place the drawing surface near the top left corner
        self.drawing_surface_rect.center = (CELL_SIZE, CELL_SIZE)

        self.current_cursor_position = None
        self.current_cursor_size = 3

        self.latest_predictions = []
        self.invalidate_predictions = True

    
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
        for symbol_class in self.dataset:
            kernel = self.kernels[symbol_class]
            inv_covariance = self.inv_covariances[symbol_class]
            dist = extern_mahalanobis_distance(self.drawing_surface, kernel, inv_covariance)[0]
            self.latest_predictions.append((dist, kernel, symbol_class))
        self.latest_predictions.sort()


    def draw(self):
        self.display.fill((0,0,0))
        if self.invalidate_predictions:
            self.run_predictions()

        # draw the drawing surface
        self.display.blit(self.drawing_surface, self.drawing_surface_rect)
        # draw the border around the drawing surface
        pygame.draw.rect(self.display, (255,255,255), self.drawing_surface_rect, 1)
        # draw the help text below the drawing surface
        render = self.font.render("Esc clears, M1 draw, M2 erases, Scroll to change size", True, (255,255,255))
        self.display.blit(render, (0, self.drawing_surface_rect.bottom + 10))
        # draw the current cursor position
        if self.current_cursor_position:
            relative_cursor_position = (self.current_cursor_position[0] - self.drawing_surface_rect.left, self.current_cursor_position[1] - self.drawing_surface_rect.top)
            pygame.draw.circle(self.display, (64, 64, 64), relative_cursor_position, self.current_cursor_size, 1)
        
        # draw the predictions
        for i, (dist, kernel, symbol_class) in enumerate(self.latest_predictions[:3]):
            render = self.font.render(f"{symbol_class}: {dist}", True, (255,255,255))
            self.display.blit(render, (self.drawing_surface_rect.right + 10, 10 + i * CELL_SIZE))
            self.display.blit(vector_to_surface(kernel), (self.drawing_surface_rect.right + 10, 10 + i * CELL_SIZE + CELL_SIZE))
            pygame.draw.rect(self.display, (255,255,255), (self.drawing_surface_rect.right + 10, 10 + i * CELL_SIZE + CELL_SIZE, CELL_SIZE, CELL_SIZE), 1)
    
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
                relative_cursor_position = (self.current_cursor_position[0] - self.drawing_surface_rect.left, self.current_cursor_position[1] - self.drawing_surface_rect.top)
                if pygame.mouse.get_pressed()[0]:  # left mouse button is pressed: draw on the drawing surface
                    pygame.draw.circle(self.drawing_surface, (255,255,255), relative_cursor_position, self.current_cursor_size)
                    self.invalidate_predictions = True
                elif pygame.mouse.get_pressed()[2]:  # right mouse button is pressed: erase on the drawing surface
                    pygame.draw.circle(self.drawing_surface, (0,0,0), relative_cursor_position, self.current_cursor_size)
                    self.invalidate_predictions = True

    def run(self):
        self.construct_dataset()
        while self.running:
            self.handle_events()
            self.draw()
            pygame.display.flip()
            self.clock.tick(30)