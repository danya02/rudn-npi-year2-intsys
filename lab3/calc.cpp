#include "calc.h"
#include <iostream>

extern "C" void compute_kernel(double** object_vectors, int ov_count, double* output_vector) {
    // For each one of the CELL_SIZE**2 cells in the object vector...
    for (int i = 0; i < CELL_SIZE * CELL_SIZE; i++) {
        // ...sum the values of that cell across all object vectors...
        double sum = 0;
        for (int j = 0; j < ov_count; j++) {
            sum += object_vectors[j][i];
            std::cout << object_vectors[j][i] << " ";
        }
        // ...and divide by the number of object vectors to get the average value of that cell.
        output_vector[i] = sum / (double)ov_count;
        std::cout << i << " " << output_vector[i] << std::endl;
    }
}

extern "C" void compute_covariance_matrix(double** object_vectors, int ov_count, double* kernel, double* output_matrix) {
    // For each first cell in the object vector...
    for (int i = 0; i < CELL_SIZE * CELL_SIZE; i++) {
        // ...for each second cell in the object vector...
        for (int j = 0; j < CELL_SIZE * CELL_SIZE; j++) {
            // ...sum the product of the difference between the first cell's value and the kernel's value
            // and the difference between the second cell's value and the kernel's value across all object vectors...
            double sum = 0;
            for (int k = 0; k < ov_count; k++) {
                sum += (object_vectors[k][i] - kernel[i]) * (object_vectors[k][j] - kernel[j]);
            }
            // ...and divide by the number of object vectors to get the average value of that cell.
            output_matrix[i * CELL_SIZE * CELL_SIZE + j] = sum / ov_count;
        }
    }
}


extern "C" void invert_matrix(double* AM, int width) {
    /// Algorithm taken from https://github.com/ThomIves/MatrixInverse/blob/master/MatrixInversion.ipynb
    #define IDX(matrix, row, col) (matrix[(row) * width + (col)])
    double* IM = new double[width*width];
    for (int i = 0; i < width; i++) {
        for (int j = 0; j < width; j++) {
            if (i == j) {
                IDX(IM, i, j) = 1;
            } else {
                IDX(IM, i, j) = 0;
            }
        }
    }

    for(int focus_diagonal=0; focus_diagonal < width; focus_diagonal++) {
        double fd_scaler = 1.0 / IDX(AM, focus_diagonal, focus_diagonal);
        for(int j=0; j < width; j++) {
            IDX(AM, focus_diagonal, j) *= fd_scaler;
            IDX(IM, focus_diagonal, j) *= fd_scaler;
        }

        for(int i=0; i < width; i++) {
            if(i == focus_diagonal) continue;
            double cr_scaler = IDX(AM, i, focus_diagonal);
            for(int j=0; j < width; j++) {
                IDX(AM, i, j) -= IDX(AM, focus_diagonal, j) * cr_scaler;
                IDX(IM, i, j) -= IDX(IM, focus_diagonal, j) * cr_scaler;
            }
        }
    }
    for(int i=0; i < width; i++) {
        for(int j=0; j < width; j++) {
            IDX(AM, i, j) = IDX(IM, i, j);
        }
    }
}

extern "C" void compute_euclid_mahalanobis_distance(double* observation_vector, double* kernel, double* inverse_covariance_matrix, double* output) {
    // 
}