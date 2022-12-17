#include "camera.cuh"

__host__ __device__ camera::camera() {}

__host__ __device__ camera::camera(vec3& _position, vec3& _direction) {
	position = _position;
	direction = _direction;
}