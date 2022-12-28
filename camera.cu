#include "camera.cuh"
#include <SFML\Graphics.hpp>

camera::camera() {
    real_direction = base_direction;
}

void camera::calculateRotationMatrix() {}

void camera::control(float speed) {
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