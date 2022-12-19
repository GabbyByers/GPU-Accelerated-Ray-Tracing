#ifndef SPHERE_CUH
#define SPHERE_CUH

#include "vec3.cuh"

class Sphere {
public:
	double radius = 1.0;
	vec3 position;

	Sphere();

	Sphere(vec3 _position, double _radius);
};

#endif