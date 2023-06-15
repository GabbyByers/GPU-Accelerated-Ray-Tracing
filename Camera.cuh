#ifndef CAMERA_CUH
#define CAMERA_CUH

#include "vec3.cuh"
#include <SFML\Graphics.hpp>

class camera
{
public:
	vec3 position = vec3(0.0f, 0.0f, 0.0f);
	vec3 base_direction = vec3(0.0f, 0.0f, 1.0f);
	vec3 real_direction;
	float depth = 2.0f;

	matrix rotation;

	camera()
	{
		real_direction = base_direction;
	}

    void control(float speed)
    {
        if (sf::Keyboard::isKeyPressed(sf::Keyboard::W))
        {
            position.z += speed;
        }
        if (sf::Keyboard::isKeyPressed(sf::Keyboard::S))
        {
            position.z += -speed;
        }
        if (sf::Keyboard::isKeyPressed(sf::Keyboard::A))
        {
            position.x += -speed;
        }
        if (sf::Keyboard::isKeyPressed(sf::Keyboard::D))
        {
            position.x += speed;
        }
        if (sf::Keyboard::isKeyPressed(sf::Keyboard::Space))
        {
            position.y += speed;
        }
        if (sf::Keyboard::isKeyPressed(sf::Keyboard::LShift))
        {
            position.y += -speed;
        }
    }

	void calculateRotationMatrix() {}
};

#endif