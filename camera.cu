#include "camera.cuh"
#include <SFML\Graphics.hpp>

camera::camera() {}

void camera::control(float speed) {
    if (sf::Keyboard::isKeyPressed(sf::Keyboard::W))
    { 
        position.z += speed;// = position.add(vec3(0, 0, speed));
    }
    if (sf::Keyboard::isKeyPressed(sf::Keyboard::A))
    {
        position.x += -speed;// = position.add(vec3(-speed, 0, 0));
    }
    if (sf::Keyboard::isKeyPressed(sf::Keyboard::S))
    {
        position.z += -speed;// = position.add(vec3(0, 0, -speed));
    }
    if (sf::Keyboard::isKeyPressed(sf::Keyboard::D))
    {
        position.x += speed;// = position.add(vec3(speed, 0, 0));
    }
    if (sf::Keyboard::isKeyPressed(sf::Keyboard::Space))
    {
        position.y += speed;// = position.add(vec3(0, speed, 0));
    }
    if (sf::Keyboard::isKeyPressed(sf::Keyboard::LShift))
    {
        position.y += -speed;// = position.add(vec3(0, -speed, 0));
    }
}