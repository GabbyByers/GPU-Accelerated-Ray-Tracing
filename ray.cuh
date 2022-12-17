#ifndef RAY_CUH
#define RAY_CUH

#include "vec3.cuh"

class ray {
public:
    vec3 origin;
    vec3 direction;

    __device__ ray();

    __device__ ray(vec3& _origin, vec3& _direction);
};

#endif