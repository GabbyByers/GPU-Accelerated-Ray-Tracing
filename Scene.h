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

    Scene(unsigned int screen_width, unsigned int screen_height)
    {
        float w = static_cast<float>(screen_width);
        float h = static_cast<float>(screen_height);
        quad.push_back(sf::Vertex(sf::Vector2f(0, 0), sf::Vector2f(0, 0)));
        quad.push_back(sf::Vertex(sf::Vector2f(w, 0), sf::Vector2f(w, 0)));
        quad.push_back(sf::Vertex(sf::Vector2f(w, h), sf::Vector2f(w, h)));
        quad.push_back(sf::Vertex(sf::Vector2f(0, h), sf::Vector2f(0, h)));
        image.create(screen_width, screen_height, sf::Color(50, 0, 0, 255));
        size = static_cast<unsigned int>(image.getSize().x) * static_cast<unsigned int>(image.getSize().y);
        width = static_cast<unsigned int>(image.getSize().x);
    }

    void draw(sf::RenderWindow& window)
    {
        texture.loadFromImage(image);
        window.draw(&quad[0], quad.size(), sf::Quads, &texture);
    }
};