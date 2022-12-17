#include "vec3.cuh"

__host__ __device__ vec3::vec3() {}

__host__ __device__ vec3::vec3(double _x, double _y, double _z) {
    x = _x;
    y = _y;
    z = _z;
}