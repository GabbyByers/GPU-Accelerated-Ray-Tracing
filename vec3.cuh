#ifndef VEC3_CUH
#define VEC3_CUH

#include <cuda_runtime.h>
#include "matrix.cuh"

class vec3
{
public:
    float x = 0.0f;
    float y = 0.0f;
    float z = 0.0f;

    __host__ __device__ vec3();

    __host__ __device__ vec3(float _x, float _y);

    __host__ __device__ vec3(float _x, float _y, float _z);

    __host__ __device__ vec3 add(vec3 vect);

    __host__ __device__ vec3 vectorMatrixMultiplication(matrix rotation);
};

#endif