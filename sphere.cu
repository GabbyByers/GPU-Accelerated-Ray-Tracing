#include "sphere.cuh"

Sphere::Sphere() {}

Sphere::Sphere(vec3 _position, double _radius) {
	position = _position;
	radius = _radius;
}