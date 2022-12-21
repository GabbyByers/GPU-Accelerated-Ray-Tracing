#ifndef CAMERA_CUH
#define CAMERA_CUH

#include "vec3.cuh"

class camera {
public:
	vec3 position = vec3(0.0f, 0.0f, 0.0f);
	vec3 direction = vec3(0.0f, 0.0f, 1.0f);
	float depth = 2.0f;

	camera();

	void control(float speed);
};

#endif