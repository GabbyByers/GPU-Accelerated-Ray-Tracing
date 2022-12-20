#include "ray.cuh"

__device__ ray::ray() {}

__device__ ray::ray(vec3 _origin, vec3 _direction) {
    origin = _origin;
    direction = _direction;
}

__device__ void ray::trace(const Sphere* gpu_spheres, unsigned int size) {
    
    float dy = direction.y - origin.y;
    float dxz = sqrt((direction.x - origin.x) * (direction.x - origin.x) + (direction.z - origin.z) * (direction.z - origin.z));
    float slope = dy / dxz;
    r = 0;
    g = 150 - slope * 100;
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

__device__ float ray::intersectSphere(const Sphere& sphere) {
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