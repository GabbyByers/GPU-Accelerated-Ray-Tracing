#include "ray.cuh"

__device__ ray::ray() {}

__device__ ray::ray(vec3 _origin, vec3 _direction) {
    origin = _origin;
    direction = _direction;
}

__device__ void ray::trace(const Sphere* gpu_spheres, unsigned int size) {
    
    // color if no collision
    double dy = direction.y - origin.y;
    double dxz = sqrt((direction.x - origin.x) * (direction.x - origin.x) + (direction.z - origin.z) * (direction.z - origin.z));
    double slope = dy / dxz;
    r = 0;
    g = 150 - slope * 100;
    b = 255;

    for (int i = 0; i < size; i++) {
        Sphere sphere = gpu_spheres[i];
        // check collision w/ spheres, over-write color if there is a collision.
    }
}