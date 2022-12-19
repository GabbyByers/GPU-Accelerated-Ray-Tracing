#ifndef VEC3_CUH
#define VEC3_CUH

#include <cuda_runtime.h>

class vec3 {
public:
    double x = 0.0;
    double y = 0.0;
    double z = 0.0;

    __host__ __device__ vec3();

    __host__ __device__ vec3(double _x, double _y);

    __host__ __device__ vec3(double _x, double _y, double _z);

    __host__ __device__ vec3 add(vec3& vect);
};

#endif