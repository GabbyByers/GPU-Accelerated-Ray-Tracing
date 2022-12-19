#include "SFML\Graphics.hpp"
#include <iostream>
#include <vector>
#include <memory>
#include "kernel.cuh"
#include "vec3.cuh"
#include "camera.cuh"
using std::cout;
using std::vector;

int main() {
    unsigned int screen_width = 1920;
    unsigned int screen_height = 1080;
    sf::RenderWindow window(sf::VideoMode(screen_width, screen_height), "GPU Accelerated Ray Tracing", sf::Style::Fullscreen | sf::Style::Close);
    sf::Event event;
    sf::Texture texture;
    camera camera;
    
    vector<sf::Vertex> quad;
    float w = static_cast<float>(screen_width);
    float h = static_cast<float>(screen_height);
    quad.push_back(sf::Vertex(sf::Vector2f(0, 0), sf::Vector2f(0, 0)));
    quad.push_back(sf::Vertex(sf::Vector2f(w, 0), sf::Vector2f(w, 0)));
    quad.push_back(sf::Vertex(sf::Vector2f(w, h), sf::Vector2f(w, h)));
    quad.push_back(sf::Vertex(sf::Vector2f(0, h), sf::Vector2f(0, h)));
    
    sf::Image scene;
    scene.create(screen_width, screen_height, sf::Color(0, 0, 0, 255));
    unsigned int size = static_cast<unsigned int>(scene.getSize().x) * static_cast<unsigned int>(scene.getSize().y);
    unsigned int width = static_cast<unsigned int>(scene.getSize().x);

    Uint8* cpu_ptr = const_cast<Uint8*>(scene.getPixelsPtr());
    Uint8* gpu_ptr = gpuSetup(cpu_ptr, size);
    
    while (window.isOpen()) {
        while (window.pollEvent(event)) {
            if (event.type == sf::Event::Closed) {
                window.close();
            }
            if (event.key.code == sf::Keyboard::Escape) {
                window.close();
            }
        }

        perPixelCalculation(camera, cpu_ptr, gpu_ptr, size, width);

        //theOldFunction(camera, cpu_ptr, size, width);

        window.clear(sf::Color(0, 0, 0));
        texture.loadFromImage(scene);
        window.draw(&quad[0], quad.size(), sf::Quads, &texture);
        window.display();
    } return 0;
}