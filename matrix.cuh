#ifndef MATRIX_CUH
#define MATRIX_CUH

#include "cuda_runtime.h"
#include <stdio.h>
#include <stdlib.h>

class matrix
{
public:
    float* cpu_matrix = nullptr;
    float* gpu_matrix = nullptr;

	matrix()
	{
		cpu_matrix = new float[9];
		for (int i = 0; i < 9; i++) { cpu_matrix[i] = 0.0f; }

		cudaMalloc((void**)&gpu_matrix, sizeof(float) * 9);

		update();
	}

	void update()
	{
		cudaMemcpy(gpu_matrix, cpu_matrix, sizeof(float) * 9, cudaMemcpyHostToDevice);
	}
};

#endif