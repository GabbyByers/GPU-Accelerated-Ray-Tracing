#include "SFML\Graphics.hpp"
#include <iostream>
#include <vector>
#include "Scene.h"
#include "kernel.cuh"
#include "vec3.cuh"
#include "camera.cuh"
#include "sphere.cuh"
#include "Enviroment.cuh"
using std::cout;
using std::vector;

int main() {
    unsigned int screen_width = 800;
    unsigned int screen_height = 400;
    sf::RenderWindow window(sf::VideoMode(screen_width, screen_height), "GPU Accelerated Ray Tracing", sf::Style::Close);
    
    Scene scene(screen_width, screen_height);
    camera camera(vec3(), vec3(0.0, 0.0, 2.0));
    
    Uint8* cpu_ptr = const_cast<Uint8*>(scene.image.getPixelsPtr());
    Uint8* gpu_ptr = gpuSetup(cpu_ptr, scene.size);
    

    Enviroment enviroment;
    enviroment.addSphere(vec3(-1.0, 0.0, 4.0), 1.2);
    enviroment.addSphere(vec3( 0.0, 0.0, 4.0), 1.2);
    enviroment.addSphere(vec3( 1.0, 0.0, 4.0), 1.2);

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

        gpuCalc(enviroment, camera, cpu_ptr, gpu_ptr, scene.size, scene.width);
        scene.draw(window);
    }
    
    gpuFree(gpu_ptr);
    enviroment.destroy();
    return 69;
}