#include "ray.cuh"

__device__ ray::ray() {}

__device__ ray::ray(vec3& _origin, vec3& _direction) {
    origin = _origin;
    direction = _direction;
}