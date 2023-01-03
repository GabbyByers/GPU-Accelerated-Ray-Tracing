#include "SFML\Graphics.hpp"
#include <iostream>
#include <vector>
#include <string>
#include "ray.cuh"
#include "Scene.h"
#include "kernel.cuh"
#include "vec3.cuh"
#include "camera.cuh"
#include "sphere.cuh"
#include "Enviroment.cuh"
using std::cout;
using std::vector;
using std::string;
using std::to_string;

class DebugInformation
{
public:

    sf::Text text;
    sf::Font CourierPrime_Regular;
    string information = "pos";

    DebugInformation()
    {
        CourierPrime_Regular.loadFromFile("CourierPrime-Regular.ttf");
        text.setFont(CourierPrime_Regular);
        text.setCharacterSize(14);
        text.setFillColor(sf::Color(255, 255, 255));
        text.setPosition(5, 0);
    }

    void draw(sf::RenderWindow& window, camera& camera, unsigned int size, unsigned int width, Sphere* cpu_spheres, unsigned int num)
    {
        string info;
        info += "Camera Position " + vec3ToString(camera.position) + "\n";
        info += "Camera Direction" + vec3ToString(camera.base_direction) + "\n";
        
        // U V
        sf::Vector2i mouse = sf::Mouse::getPosition(window);
        float u = mouse.x / static_cast<float>(width);
        float v = mouse.y / static_cast<float>(size / width);
        u = (2.0f * u) - 1.0f;
        v = (2.0f * v) - 1.0f;
        u = u * (width / static_cast<float>(size / width));
        v = -v;
        
        info += "U: ";
        if (u >= 0) { info += " "; }
        info += to_string(u);
        info += " V: ";
        if (v >= 0) { info += " "; }
        info += to_string(v) + "\n";
        
        text.setString(info);
        window.draw(text);
    }

    string vec3ToString(vec3 vec) {
        string result;
        result += " x: ";
        if (vec.x >= 0) { result += " "; }
        result += to_string(vec.x);
        result += " y: ";
        if (vec.y >= 0) { result += " "; }
        result += to_string(vec.y);
        result += " z: ";
        if (vec.z >= 0) { result += " "; }
        result += to_string(vec.z);
        return result;
    }
};

int main()
{
    unsigned int screen_width = 1920;
    unsigned int screen_height = 1080;
    sf::RenderWindow window(sf::VideoMode(screen_width, screen_height), "GPU Accelerated Ray Tracing", sf::Style::Fullscreen | sf::Style::Close);
    
    Scene scene(screen_width, screen_height);
    camera camera;
    
    Uint8* cpu_ptr = const_cast<Uint8*>(scene.image.getPixelsPtr());
    Uint8* gpu_ptr = gpuSetup(cpu_ptr, scene.size);
    
    Enviroment enviroment;
    //enviroment.addSphere(Sphere(vec3(-2.5f, 0.0f, 4.0f), 1.0f, 255, 0, 0));
    //enviroment.addSphere(Sphere(vec3( 0.0f, 0.0f, 4.0f), 1.0f, 0, 255, 0));
    //enviroment.addSphere(Sphere(vec3( 1.8f, 0.0f, 4.0f), 1.0f, 0, 0, 255));

    srand(NULL);
    for (int i = 0; i < 20; i++)
    {
        enviroment.addSphere(Sphere(vec3(-10.0f + i, 0.0f, 6.0f), 0.2f + (static_cast<float>(rand()) / RAND_MAX), rand() % 255, rand() % 255, rand() % 255));
    }

    //for (int i = 0; i < 100; i++) {
    //    Uint8 r = std::rand() % 255;
    //    Uint8 g = std::rand() % 255;
    //    Uint8 b = std::rand() % 255;
    //    float radius = static_cast<float>(std::rand()) / RAND_MAX;
    //    float depth = static_cast<float>(std::rand()) / RAND_MAX;
    //    float width = static_cast<float>(std::rand()) / RAND_MAX;
    //    enviroment.addSphere(Sphere(vec3(-30.0f + 60.0f * width, 0.0f, 4.0f + 60.0f * depth), radius + 0.5, r, g, b));
    //}

    DebugInformation debugInformation;

    float time = 0.0f;

    sf::Event event;
    while (window.isOpen())
    {
        while (window.pollEvent(event))
        {
            if (event.type == sf::Event::Closed)
            {
                window.close();
            }
            if (event.type == sf::Event::KeyPressed)
            {
                if (event.key.code == sf::Keyboard::Escape)
                {
                    cout << "ESCAPE KEY PRESSED\n\n\n\n";
                    window.close();
                }
            }
        }

        time += 0.01;

        for (int i = 0; i < enviroment.num_spheres; i++)
        {
            Sphere& sphere = enviroment.cpu_spheres[i];
            sphere.position.y = sin(time + i) * 2.0f;
        }

        enviroment.updateSpheres();

        camera.control(0.05f);
        gpuCalc(enviroment, camera, cpu_ptr, gpu_ptr, scene.size, scene.width);
        scene.draw(window);
        debugInformation.draw(window, camera, scene.size, scene.width, enviroment.cpu_spheres, enviroment.num_spheres);
        window.display();
    }
    
    gpuFree(gpu_ptr);
    enviroment.destroy();
    return 69;
}