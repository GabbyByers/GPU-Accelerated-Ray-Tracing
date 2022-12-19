#include "SFML\Graphics.hpp"
#include <iostream>
#include <vector>
#include "Scene.h"
#include "kernel.cuh"
#include "vec3.cuh"
#include "camera.cuh"
using std::cout;
using std::vector;

int main() {
    unsigned int screen_width = 800;
    unsigned int screen_height = 800;
    sf::RenderWindow window(sf::VideoMode(screen_width, screen_height), "GPU Accelerated Ray Tracing", sf::Style::Close);
    
    Scene scene(screen_width, screen_height);
    camera camera;
    
    Uint8* cpu_ptr = const_cast<Uint8*>(scene.image.getPixelsPtr());
    Uint8* gpu_ptr = gpuSetup(cpu_ptr, scene.size);
    
    sf::Event event;
    while (window.isOpen()) {
        while (window.pollEvent(event)) {
            if (event.type == sf::Event::Closed) {
                window.close();
            }
            if (event.key.code == sf::Keyboard::Escape) {
                window.close();
            }
        }

        gpuCalc(camera, cpu_ptr, gpu_ptr, scene.size, scene.width);
        scene.draw(window);
    }
    
    gpuFree(gpu_ptr);
    return 69;
}