#include "matrix.cuh"

#include <stdio.h>
#include <stdlib.h>

matrix::matrix() {

	cpu_matrix = new float*[3];
	for (int i = 0; i < 3; i++) {
		cpu_matrix[i] = new float[3];
	}

	cudaMalloc((void**)&gpu_matrix, sizeof(float*) * 3);
	for (int i = 0; i < 3; i++) {
		cudaMalloc((void**)&gpu_matrix[i], sizeof(float) * 3);
	}

	//update();
}

void matrix::update() {
	for (int i = 0; i < 3; i++) {
		cudaMemcpy(gpu_matrix[i], cpu_matrix[i], sizeof(float) * 3, cudaMemcpyHostToDevice);
	}
}



