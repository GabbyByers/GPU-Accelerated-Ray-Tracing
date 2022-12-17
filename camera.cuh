#ifndef CAMERA_CUH
#define CAMERA_CUH

#include "vec3.cuh"

class camera {
public:
	vec3 position;
	vec3 direction;

	__host__ __device__ camera();

	__host__ __device__ camera(vec3& _position, vec3& _direction);
};

#endif