#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <math.h>
#include "vec3.cuh"

typedef unsigned char Uint8;

__global__ void kernel(Uint8* ptr, unsigned int size, unsigned int width) {
    unsigned int i = (blockIdx.x * blockDim.x) + threadIdx.x;
    if (i < size) {
        Uint8* RGBA = ptr + (i * 4);
        Uint8& r = *   RGBA;
        Uint8& g = * ++RGBA;
        Uint8& b = * ++RGBA;

        unsigned int x = i % width;
        unsigned int y = i / width;
        double u = x / static_cast<double>(width);
        double v = y / static_cast<double>(size / width);

        vec3 ray(u, 0.0, v);

        r = ray.x * 255;
        g = ray.y * 255;
        b = ray.z * 255;
    }
}

void perPixelCalculation(Uint8* scene, unsigned int size, unsigned int width) {
    unsigned int bytes = size * 4;
    Uint8* ptr = nullptr;

    cudaMalloc((void**)&ptr, bytes);
    cudaMemcpy(ptr, scene, bytes, cudaMemcpyHostToDevice);

    int NUM_THREADS = 1024;
    int NUM_BLOCKS = (size + NUM_THREADS - 1) / NUM_THREADS;
    kernel <<<NUM_BLOCKS, NUM_THREADS>>> (ptr, size, width);

    cudaMemcpy(scene, ptr, bytes, cudaMemcpyDeviceToHost);
    cudaFree(ptr);
}
