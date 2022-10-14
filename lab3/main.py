import pygame
import extern_calc
import dataset

if __name__ == '__main__':
    data_set = dataset.construct_dataset(dataset.load_fonts(), "012345")
    for digit in data_set:
        print(digit)
        digit_list = data_set[digit]

        kernel = extern_calc.extern_class_into_kernel(digit_list)
        kernel_surface = extern_calc.vector_to_surface(kernel)
        pygame.image.save(kernel_surface, f"kernel-{digit}.png")

        covariance = extern_calc.extern_class_into_covariance(digit_list, kernel)
        extern_calc.add_identity(covariance)
        extern_calc.extern_class_into_inverse(covariance)
        avg_dist = dict()
        for digit in data_set:
            print("Checking digit", digit)
            sum_dist = 0
            count = 0
            for img in data_set[digit]:
                dist = extern_calc.extern_mahalanobis_distance(img, kernel, covariance)[0]
                sum_dist += dist
                count += 1
            avg_dist[digit] = sum_dist / count
        print(avg_dist)
