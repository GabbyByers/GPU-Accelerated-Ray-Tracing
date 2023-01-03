#include "matrix.cuh"

#include <stdio.h>
#include <stdlib.h>

matrix::matrix()
{	
	cpu_matrix = new float[9];
	for (int i = 0; i < 9; i++) { cpu_matrix[i] = 0.0f; }
	
	cudaMalloc((void**)&gpu_matrix, sizeof(float) * 9);
	
	update();
}

void matrix::update()
{
	cudaMemcpy(gpu_matrix, cpu_matrix, sizeof(float) * 9, cudaMemcpyHostToDevice);
}