#ifndef CAMERA_CUH
#define CAMERA_CUH

#include "vec3.cuh"

class camera {
public:
	vec3 position;
	vec3 direction;

	camera();

	camera(vec3 _position, vec3 _direction);
};

#endif