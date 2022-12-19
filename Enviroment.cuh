#ifndef ENVIROMENT_CUH
#define ENVIROMENT_CUH

#include "cuda_runtime.h"
#include "sphere.cuh"
#include <string.h>

class Enviroment {
public:
    unsigned int num_spheres = 0;

    Sphere* cpu_spheres = nullptr;
    Sphere* gpu_spheres = nullptr;

    Enviroment();

    void addSphere(vec3& position, double radius);

    void destroy();
};

#endif