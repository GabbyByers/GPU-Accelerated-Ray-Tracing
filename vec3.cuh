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

    __host__ __device__ vec3() {}

    __host__ __device__ vec3(float _x, float _y)
    {
        x = _x;
        y = _y;
    }

    __host__ __device__ vec3(float _x, float _y, float _z)
    {
        x = _x;
        y = _y;
        z = _z;
    }

    __host__ __device__ vec3 add(vec3 vect)
    {
        vec3 result;
        result.x = x + vect.x;
        result.y = y + vect.y;
        result.z = z + vect.z;
        return result;
    }

    __host__ __device__ vec3 vectorMatrixMultiplication(matrix roation)
    {
        vec3 result;
        // myself multiplied by the matrix
        return result;
    }
};

#endif