import pygame
import extern_calc
import dataset

if __name__ == '__main__':
    data_set = dataset.construct_dataset(dataset.load_fonts(), "0")
    zeros_list = data_set["0"]
    for i, zero in enumerate(zeros_list):
        pygame.image.save(zero, f"zero_{i}.png")
    kernel = extern_calc.extern_class_into_kernel(zeros_list)
    kernel_surface = extern_calc.vector_to_surface(kernel)
    pygame.image.save(kernel_surface, "kernel.png")
