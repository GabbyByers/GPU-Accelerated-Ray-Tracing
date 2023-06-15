#ifndef ENVIROMENT_CUH
#define ENVIROMENT_CUH

#include "cuda_runtime.h"
#include "sphere.cuh"
#include <string.h>

class Enviroment
{
public:
    unsigned int num_spheres = 0;

    Sphere* cpu_spheres = nullptr;
    Sphere* gpu_spheres = nullptr;

    Enviroment() {}

    void addSphere(Sphere sphere) {
        num_spheres++;

        // CPU
        Sphere* new_cpu_spheres = new Sphere[num_spheres];
        memcpy(new_cpu_spheres, cpu_spheres, sizeof(Sphere) * (num_spheres - 1));
        delete[] cpu_spheres;
        cpu_spheres = new_cpu_spheres;
        cpu_spheres[num_spheres - 1] = sphere;

        // GPU
        cudaFree(gpu_spheres);
        cudaMalloc((void**)&gpu_spheres, sizeof(Sphere) * num_spheres);
        cudaMemcpy(gpu_spheres, cpu_spheres, sizeof(Sphere) * num_spheres, cudaMemcpyHostToDevice);
    }

    void destroy() {
        delete[] cpu_spheres;
        cudaFree(gpu_spheres);
    }

    void updateSpheres() {
        cudaMemcpy(gpu_spheres, cpu_spheres, sizeof(Sphere) * num_spheres, cudaMemcpyHostToDevice);
    }
};

#endif