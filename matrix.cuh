#ifndef MATRIX_CUH
#define MATRIX_CUH

#include "cuda_runtime.h"

class matrix {
public:
    float** cpu_matrix = nullptr;
    float** gpu_matrix = nullptr;

    matrix();

    void update();
};

#endif