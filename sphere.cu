#include "sphere.cuh"

Sphere::Sphere() {}

Sphere::Sphere(vec3 _position, float _radius, Uint8 _r, Uint8 _g, Uint8 _b) {
	position = _position;
	radius = _radius;
	r = _r;
	g = _g;
	b = _b;
}