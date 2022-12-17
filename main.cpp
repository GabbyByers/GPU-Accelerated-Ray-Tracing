#include "SFML\Graphics.hpp"
#include <iostream>
#include <vector>
#include "kernel.cuh"
#include "vec3.cuh"
#include "camera.cuh"
using std::cout;
using std::vector;

int main() {
    unsigned int screen_width = 800;
    unsigned int screen_height = 800;
    sf::RenderWindow window(sf::VideoMode(screen_width, screen_height), "GPU Accelerated Ray Tracing", sf::Style::Close);
    sf::Event event;
    
    vector<sf::Vertex> quad;
    float w = static_cast<float>(screen_width);
    float h = static_cast<float>(screen_height);
    quad.push_back(sf::Vertex(sf::Vector2f(0, 0), sf::Vector2f(0, 0)));
    quad.push_back(sf::Vertex(sf::Vector2f(w, 0), sf::Vector2f(w, 0)));
    quad.push_back(sf::Vertex(sf::Vector2f(w, h), sf::Vector2f(w, h)));
    quad.push_back(sf::Vertex(sf::Vector2f(0, h), sf::Vector2f(0, h)));
    
    sf::Image scene;
    scene.create(screen_width, screen_height, sf::Color(0, 0, 0, 255));
    Uint8* pixels = const_cast<Uint8*>(scene.getPixelsPtr());
    unsigned int size = static_cast<unsigned int>(scene.getSize().x) * static_cast<unsigned int>(scene.getSize().y);
    unsigned int width = static_cast<unsigned int>(scene.getSize().x);

    sf::Texture texture;

    camera camera;

    while (window.isOpen()) {
        while (window.pollEvent(event)) {
            if (event.type == sf::Event::Closed) {
                window.close();
            }
            if (event.key.code == sf::Keyboard::Escape) {
                window.close();
            }
        }

        perPixelCalculation(camera, pixels, size, width);

        window.clear(sf::Color(0, 0, 0));
        texture.loadFromImage(scene);
        window.draw(&quad[0], quad.size(), sf::Quads, &texture);
        window.display();
    } return 0;
}