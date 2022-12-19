#ifndef RAY_CUH
#define RAY_CUH

#include "vec3.cuh"
#include "kernel.cuh"

class ray {
public:
    vec3 origin;
    vec3 direction;

    Uint8 r = 0;
    Uint8 g = 0;
    Uint8 b = 0;

    __device__ ray();

    __device__ ray(vec3 _origin, vec3 _direction);

    __device__ void trace(const Sphere* gpu_spheres, unsigned int size);
};

#endif