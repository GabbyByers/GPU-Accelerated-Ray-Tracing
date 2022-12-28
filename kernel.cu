#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <math.h>
#include "kernel.cuh"
#include "vec3.cuh"
#include "camera.cuh"
#include "ray.cuh"
#include "sphere.cuh"
#include "Enviroment.cuh"

__global__ void kernel(Enviroment enviroment, camera camera, Uint8* gpu_ptr, unsigned int size, unsigned int width) {
    unsigned int i = (blockIdx.x * blockDim.x) + threadIdx.x;
    if (i >= size) { return; }
    
    Uint8* RGBA = gpu_ptr + (i * 4);
    Uint8& r = *   RGBA;
    Uint8& g = * ++RGBA;
    Uint8& b = * ++RGBA;

    unsigned int x = i % width;
    unsigned int y = i / width;

    float u = x / static_cast<float>(width);
    float v = y / static_cast<float>(size / width);

    u = (2.0f * u) - 1.0f;
    v = (2.0f * v) - 1.0f;

    u = u * (width / static_cast<float>(size / width));
    v = -v;

    vec3 origin = camera.position;
    vec3 base_direction = vec3(u, v, camera.depth);

    vec3 real_direction = base_direction.vectorMatrixMultiplication(camera.rotation);
    
    ray ray(origin, real_direction);
    ray.trace(enviroment.gpu_spheres, enviroment.num_spheres);

    r = ray.r;
    g = ray.g;
    b = ray.b;
}

Uint8* gpuSetup(Uint8* cpu_ptr, unsigned int size) {
    unsigned int bytes = size * 4;
    Uint8* gpu_ptr = nullptr;
    cudaMalloc((void**)&gpu_ptr, bytes);
    cudaMemcpy(gpu_ptr, cpu_ptr, bytes, cudaMemcpyHostToDevice);
    return gpu_ptr;
}

void gpuCalc(Enviroment& enviroment, camera& camera, Uint8* cpu_ptr, Uint8* gpu_ptr, unsigned int size, unsigned int width) {
    unsigned int NUM_THREADS = 512;
    unsigned int NUM_BLOCKS = (size + NUM_THREADS - 1) / NUM_THREADS;
    kernel <<<NUM_BLOCKS, NUM_THREADS>>> (enviroment, camera, gpu_ptr, size, width);

    unsigned int bytes = size * 4;
    cudaMemcpy(cpu_ptr, gpu_ptr, bytes, cudaMemcpyDeviceToHost);
}

void gpuFree(Uint8* gpu_ptr) {
    cudaFree(gpu_ptr);
}