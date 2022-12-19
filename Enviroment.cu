#include "Enviroment.cuh"

Enviroment::Enviroment() {}

void Enviroment::addSphere(vec3& position, double radius) {
    num_spheres++;

    // CPU
    Sphere* new_cpu_spheres = new Sphere[num_spheres];
    memcpy(new_cpu_spheres, cpu_spheres, sizeof(Sphere) * (num_spheres - 1));
    delete[] cpu_spheres;
    cpu_spheres = new_cpu_spheres;
    Sphere new_sphere(position, radius);
    cpu_spheres[num_spheres - 1] = new_sphere;

    // GPU
    cudaFree(gpu_spheres);
    cudaMalloc((void**)&gpu_spheres, sizeof(Sphere) * num_spheres);
    cudaMemcpy(gpu_spheres, cpu_spheres, sizeof(Sphere) * num_spheres, cudaMemcpyHostToDevice);
}

void Enviroment::destroy() {
    delete[] cpu_spheres;
    cudaFree(gpu_spheres);
}