extern "C" const int CELL_SIZE = 32;

// Computes the kernel of a class -- the average vector between a list of object vectors of that class.
// `object_vectors` is a list of pointers to object vectors. Each object vector is CELL_SIZE**2 long.
// `ov_count` is the number of object vectors in `object_vectors`.
// `output_vector` is a pointer to a list of doubles of length CELL_SIZE**2 that will be filled with the kernel.
extern "C" void compute_kernel(double** object_vectors, int ov_count, double* output_vector);

// Replaces the matrix supplied with its inverse.
// `AM` is a pointer to a list of doubles of length `width`**2 that will be replaced with its inverse.
// `width` is the width (and also height) of the matrix.
extern "C" void invert_matrix(double* AM, long long width);

// Computes the covariance matrix of a class.
// `object_vectors` is a list of pointers to object vectors. Each object vector is CELL_SIZE**2 long.
// `ov_count` is the number of object vectors in `object_vectors`.
// `kernel` is a pointer to a list of doubles of length CELL_SIZE**2 that is the kernel of the class.
// `output_matrix` is a pointer to a list of doubles of length (CELL_SIZE**2)**2 that will be filled with the covariance matrix.
extern "C" void compute_covariance_matrix(double** object_vectors, int ov_count, double* kernel, double* output_matrix);

// Computes the Mahalanobis distance between an observation vector and a class.
// (If you want Euclid-Mahalanobis, add the identity matrix to the covariance matrix before inverting it.)
// `observation_vector` is a pointer to a list of doubles of length CELL_SIZE**2 that is the observation vector.
// `kernel` is a pointer to a list of doubles of length CELL_SIZE**2 that is the kernel of the class.
// `inverse_covariance_matrix` is a pointer to a list of doubles of length (CELL_SIZE**2)**2 that is the inverse of the covariance matrix of the class.
// `output` is a pointer to two doubles. The first one will be set to the distance, the second to the squared distance.
extern "C" void compute_mahalanobis_distance(double* observation_vector, double* kernel, double* inverse_covariance_matrix, double* output);