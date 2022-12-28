#ifndef CAMERA_CUH
#define CAMERA_CUH

#include "vec3.cuh"

class camera {
public:
	vec3 position = vec3(0.0f, 0.0f, 0.0f);
	vec3 base_direction = vec3(0.0f, 0.0f, 1.0f);
	vec3 real_direction;
	float depth = 2.0f;

	float rotation_matrix[3][3];

	camera();

	void control(float speed);

	void calculateRotationMatrix();
};

#endif