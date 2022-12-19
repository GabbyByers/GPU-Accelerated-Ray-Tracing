#include "camera.cuh"

camera::camera() {}

camera::camera(vec3& _position, vec3& _direction) {
	position = _position;
	direction = _direction;
}