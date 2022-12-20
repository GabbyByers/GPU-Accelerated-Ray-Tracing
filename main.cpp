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
    unsigned int screen_width = 1000;
    unsigned int screen_height = 500;
    sf::RenderWindow window(sf::VideoMode(screen_width, screen_height), "GPU Accelerated Ray Tracing", sf::Style::Close);
    
    Scene scene(screen_width, screen_height);
    vec3 cam_pos(0.0f, 0.0f, 0.0f);
    vec3 cam_dir(0.0f, 0.0f, 2.0f);
    camera camera(cam_pos, cam_dir);
    
    Uint8* cpu_ptr = const_cast<Uint8*>(scene.image.getPixelsPtr());
    Uint8* gpu_ptr = gpuSetup(cpu_ptr, scene.size);
    
    Enviroment enviroment;
    enviroment.addSphere(Sphere(vec3(-1.0f, 0.0f, 4.0f), 1.2f, 255, 0, 0));
    enviroment.addSphere(Sphere(vec3( 0.0f, 0.0f, 4.0f), 1.2f, 0, 255, 0));
    enviroment.addSphere(Sphere(vec3( 1.0f, 0.0f, 4.0f), 1.2f, 0, 0, 255));

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