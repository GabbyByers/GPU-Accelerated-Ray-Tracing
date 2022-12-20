#ifndef SPHERE_CUH
#define SPHERE_CUH

#include "vec3.cuh"
typedef unsigned char Uint8;

class Sphere {
public:
	float radius = 1.0;
	vec3 position;

	Uint8 r = 0;
	Uint8 g = 0;
	Uint8 b = 0;

	Sphere();

	Sphere(vec3 _position, float _radius, Uint8 _r, Uint8 _g, Uint8 _b);
};

#endif