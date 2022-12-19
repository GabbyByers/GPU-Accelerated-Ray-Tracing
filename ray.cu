#include "ray.cuh"

__device__ ray::ray() {}

__device__ ray::ray(vec3 _origin, vec3 _direction) {
    origin = _origin;
    direction = _direction;
}

__device__ void ray::trace(const Sphere* gpu_spheres, unsigned int size) {
    for (int i = 0; i < size; i++) {
        Sphere sphere = gpu_spheres[i];
        if (sphere.radius > 5.0) {
            r = 0;
        }
        if (sphere.radius > 10.0) {
            g = 0;
        }
        if (sphere.radius > 15.0) {
            b = 0;
        }
    }
}