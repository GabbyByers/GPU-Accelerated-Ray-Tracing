#ifndef VEC3_CUH
#define VEC3_CUH

#include <cuda_runtime.h>

__device__ class vec3 {
public:
    double x = 0.0;
    double y = 0.0;
    double z = 0.0;

    __device__ vec3(double _x, double _y, double _z);
};

#endif