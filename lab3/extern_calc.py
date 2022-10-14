import pygame
from typing import List
from ctypes import *
calc = CDLL('/home/danya/Documents/university/rudn-npi-year2-intsys/lab3/calc.so')

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
    surface = pygame.Surface((CELL_SIZE, CELL_SIZE))
    for y in range(CELL_SIZE):
        for x in range(CELL_SIZE):
            value = int(vector[y * CELL_SIZE + x] * 255)
            surface.set_at((x, y), (value, value, value))
    return surface

def object_class_into_ptrptr(object_class: List[pygame.Surface]) -> POINTER(POINTER(c_double)):
    """
    Converts every object from an object class into its corresponding vector (producing a pointer to doubles),
    then puts the pointers to those into an array
    and returns the pointer to that array.

    Guarantees that len(object_class) == len(object_vectors_array_pointer)
    """

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

    return object_vectors_array_pointer


def extern_class_into_kernel(object_class: List[pygame.Surface] | POINTER(POINTER(c_double))) -> vector_type:
    """Convert a class of pygame surfaces to a vector representation of the kernel of the class"""

    # If the object class has already been turned into a pointer to an array of pointers to vectors,
    # then we can just pass it directly to the C function;
    # otherwise, we need to convert it first
    if isinstance(object_class, list):
        object_vectors_array_pointer = object_class_into_ptrptr(object_class)
    else:
        object_vectors_array_pointer = object_class

    kernel = vector_type()

    calc.compute_kernel.argtypes = [POINTER(POINTER(c_double)), c_int, POINTER(c_double)]
    calc.compute_kernel(object_vectors_array_pointer, len(object_class), kernel)
    return kernel

def extern_class_into_covariance(object_class: List[pygame.Surface] | POINTER(POINTER(c_double)), kernel: vector_type) -> matrix_type:
    """Given an object class and its kernel, construct a covariance matrix."""

    # If the object class has already been turned into a pointer to an array of pointers to vectors,
    # then we can just pass it directly to the C function;
    # otherwise, we need to convert it first
    if isinstance(object_class, list):
        object_vectors_array_pointer = object_class_into_ptrptr(object_class)
    else:
        object_vectors_array_pointer = object_class

    covariance = matrix_type()

    calc.compute_covariance_matrix.argtypes = [POINTER(POINTER(c_double)), c_int, POINTER(c_double), POINTER(c_double)]
    calc.compute_covariance_matrix(object_vectors_array_pointer, len(object_class), kernel, covariance)
    return covariance

def add_identity(covariance: matrix_type) -> matrix_type:
    """
    Add the identity matrix to the covariance matrix. This is done to prevent division by zero errors.
    
    Modifies the covariance matrix in place and returns it.
    """
    for i in range(CELL_SIZE**2):
        covariance[i * CELL_SIZE**2 + i] += 1
    return covariance

def extern_class_into_inverse(covariance: matrix_type) -> matrix_type:
    """
    Given a covariance matrix, compute its inverse.

    Modifies the covariance matrix in place and returns it.
    """
    calc.invert_matrix.argtypes = [POINTER(c_double), c_longlong]
    calc.invert_matrix(covariance, (CELL_SIZE**2))
    return covariance

def extern_mahalanobis_distance(observation: vector_type | pygame.Surface, kernel: vector_type, covariance: matrix_type) -> List[float]:
    """Compute the Mahalanobis distance between an observation and a class."""

    # if the observation vector is not yet a vector, convert it first
    if not isinstance(observation, vector_type):
        observation = surface_to_vector(observation)

    distance = c_double * 2
    distance = distance()
    calc.compute_mahalanobis_distance.argtypes = [POINTER(c_double), POINTER(c_double), POINTER(c_double), POINTER(c_double)]
    calc.compute_mahalanobis_distance(observation, kernel, covariance, distance)
    return [distance[0], distance[1]]
