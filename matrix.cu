#include "matrix.cuh"

#include <stdio.h>
#include <stdlib.h>

matrix::matrix() {

	cpu_matrix = new float[9];

	cudaMalloc((void**)&gpu_matrix, sizeof(float) * 9);

	//update();
}

void matrix::update() {}



