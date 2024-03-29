#ifndef RAY_CUH
#define RAY_CUH

#include "vec3.cuh"
#include "kernel.cuh"
#include "sphere.cuh"

class ray
{
public:
    vec3 origin;
    vec3 direction;

    Uint8 r = 0;
    Uint8 g = 0;
    Uint8 b = 0;

    __host__ __device__ ray() {}

    __host__ __device__ ray(vec3 _origin, vec3 _direction)
    {
        origin = _origin;
        direction = _direction;
    }

    __host__ __device__ void trace(const Sphere* gpu_spheres, unsigned int size)
    {
        r = 0;
        g = 180 - 75 * direction.y;
        b = 255;

        float current_t = FLT_MAX;
        for (int i = 0; i < size; i++) {
            const Sphere& sphere = gpu_spheres[i];
            float new_t = intersectSphere(sphere);
            if (new_t < current_t) {
                current_t = new_t;
                r = sphere.r;
                g = sphere.g;
                b = sphere.b;
            }
        }
    }

    __host__ __device__ float intersectSphere(const Sphere& sphere)
    {
        vec3 A = origin;
        vec3 B = direction;
        vec3 C = sphere.position;

        float r = sphere.radius;

        float a = (B.x * B.x) + (B.y * B.y) + (B.z * B.z);
        float b = (2.0f * A.x * B.x) + (-2.0f * B.x * C.x) + (2.0f * A.y * B.y) + (-2.0f * B.y * C.y) + (2.0f * A.z * B.z) + (-2.0f * B.z * C.z);
        float c = (A.x * A.x) + (-2.0f * A.x * C.x) + (C.x * C.x) + (A.y * A.y) + (-2.0f * A.y * C.y) + (C.y * C.y) + (A.z * A.z) + (-2.0f * A.z * C.z) + (C.z * C.z) - (r * r);

        float discriminant = (b * b) + (-4.0f * a * c);
        if (discriminant <= 0) { return FLT_MAX; }

        float t0 = (-b + sqrt(discriminant)) / (2.0f * a);
        float t1 = (-b - sqrt(discriminant)) / (2.0f * a);

        if (t0 <= 0.0f) { t0 = FLT_MAX; }
        if (t1 <= 0.0f) { t1 = FLT_MAX; }

        if (t0 <= t1) { return t0; }
        if (t1 <= t0) { return t1; }
    }
};

#endif