#ifndef SPHERE_CUH
#define SPHERE_CUH

#include "vec3.cuh"

class Sphere {
public:
	double radius = 1.0;
	vec3 position;

	__host__ __device__ Sphere() {}

	__host__ __device__ Sphere(vec3 _position, double _radius) {
		position = _position;
		radius = _radius;
	}
};

#endif