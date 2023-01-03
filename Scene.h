#pragma once

#include <SFML\Graphics.hpp>
#include <vector>
using std::vector;

class Scene
{
public:
    vector<sf::Vertex> quad;
    sf::Texture texture;
    sf::Image image;
    unsigned int size;
    unsigned int width;

    Scene(unsigned int screen_width, unsigned int screen_height);

    void draw(sf::RenderWindow& window);
};