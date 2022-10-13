import pygame
from typing import List
from ctypes import *
calc = CDLL('./calc.so')

CELL_SIZE = c_int.in_dll(calc, 'CELL_SIZE').value

vector_type = c_double * (CELL_SIZE**2)  # The type representing a single object (a cell grid, for example 16*16=256 pixels)
matrix_type = c_double * (CELL_SIZE**4)  # The type representing the covariance matrix (256*256=65536 values)

def surface_to_vector(surface: pygame.Surface) -> vector_type:
    """Convert a pygame surface to the vector representation"""
    if surface.get_width() != CELL_SIZE or surface.get_height() != CELL_SIZE:
        raise ValueError(f"Surface must be {CELL_SIZE}x{CELL_SIZE} pixels")
    vector = matrix_type()
    for y in range(CELL_SIZE):
        for x in range(CELL_SIZE):
            value = surface.get_at((x, y)).r / 255  # using only red channel, assuming grayscale images
            vector[y * CELL_SIZE + x] = value
    return vector

def vector_to_surface(vector: vector_type) -> pygame.Surface:
    """Convert a vector representation to a pygame surface"""
    print(vector[:])
    surface = pygame.Surface((CELL_SIZE, CELL_SIZE))
    for y in range(CELL_SIZE):
        for x in range(CELL_SIZE):
            value = int(vector[y * CELL_SIZE + x] * 255)
            surface.set_at((x, y), (value, value, value))
    return surface

def extern_class_into_kernel(object_class: List[pygame.Surface]) -> vector_type:
    """Convert a class of pygame surfaces to a vector representation of the kernel of the class"""
    # for each object, construct a vector from it
    object_vectors: List[vector_type] = []
    for surf in object_class:
        vector = surface_to_vector(surf)
        object_vectors.append(vector)
    
    # create a list of pointers to the vectors
    object_vectors_pointers = (POINTER(c_double) * len(object_vectors))()
    for i, vector in enumerate(object_vectors):
        object_vectors_pointers[i] = cast(vector, POINTER(c_double))
    
    # convert the list of pointers into a C array
    object_vectors_array = (POINTER(c_double) * len(object_vectors))(*object_vectors_pointers)

    # get the pointer to the list of pointers
    object_vectors_array_pointer = cast(object_vectors_array, POINTER(POINTER(c_double)))

    # call the kernel computation function
    kernel = vector_type()

    calc.compute_kernel.argtypes = [POINTER(POINTER(c_double)), c_int, POINTER(c_double)]
    calc.compute_kernel(object_vectors_array_pointer, len(object_vectors), kernel)
    return kernel
