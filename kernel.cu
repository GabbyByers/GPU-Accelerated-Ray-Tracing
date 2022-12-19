#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <math.h>
#include "kernel.cuh"
#include "vec3.cuh"
#include "camera.cuh"
#include "ray.cuh"

__global__ void kernel(camera& camera, Uint8* gpu_ptr, unsigned int size, unsigned int width) {
    unsigned int i = (blockIdx.x * blockDim.x) + threadIdx.x;
    if (i >= size) { return; }

    Uint8* RGBA = gpu_ptr + (i * 4);
    Uint8& r = *   RGBA;
    Uint8& g = * ++RGBA;
    Uint8& b = * ++RGBA;

    unsigned int x = i % width;
    unsigned int y = i / width;
    double u = x / static_cast<double>(width);
    double v = y / static_cast<double>(size / width);
    u = (2.0 * u) - 1.0;
    v = (2.0 * v) - 1.0;
    v = -v;

    r = abs(u) * 255;
    b = abs(v) * 255;

    //vec3 pixel(u, v, 0.0);
    //ray camera_ray(camera.position, camera.direction.add(pixel));
}

Uint8* gpuSetup(Uint8* cpu_ptr, unsigned int size) {
    unsigned int bytes = size * 4;
    Uint8* gpu_ptr = nullptr;
    cudaMalloc((void**)&gpu_ptr, bytes);
    cudaMemcpy(gpu_ptr, cpu_ptr, bytes, cudaMemcpyHostToDevice);
    return gpu_ptr;
}

void perPixelCalculation(camera& camera, Uint8* cpu_ptr, Uint8* gpu_ptr, unsigned int size, unsigned int width) {
    unsigned int NUM_THREADS = 1024;
    unsigned int NUM_BLOCKS = (size + NUM_THREADS - 1) / NUM_THREADS;
    kernel <<<NUM_BLOCKS, NUM_THREADS>>> (camera, gpu_ptr, size, width);

    unsigned int bytes = size * 4;
    cudaMemcpy(cpu_ptr, gpu_ptr, bytes, cudaMemcpyDeviceToHost);
    //cudaFree(gpu_ptr);
}

void theOldFunction(camera& camera, Uint8* cpu_ptr, unsigned int size, unsigned int width) {
    unsigned int bytes = size * 4;
    Uint8* gpu_ptr = nullptr;

    cudaMalloc((void**)&gpu_ptr, bytes);
    cudaMemcpy(gpu_ptr, cpu_ptr, bytes, cudaMemcpyHostToDevice);

    unsigned int NUM_THREADS = 1024;
    unsigned int NUM_BLOCKS = (size + NUM_THREADS - 1) / NUM_THREADS;
    kernel << <NUM_BLOCKS, NUM_THREADS >> > (camera, gpu_ptr, size, width);

    cudaMemcpy(cpu_ptr, gpu_ptr, bytes, cudaMemcpyDeviceToHost);
    cudaFree(gpu_ptr);
}