#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <math.h>
#include "kernel.cuh"
#include "vec3.cuh"
#include "camera.cuh"
#include "ray.cuh"

__global__ void kernel(camera& camera, Uint8* ptr, unsigned int size, unsigned int width) {
    unsigned int i = (blockIdx.x * blockDim.x) + threadIdx.x;
    if (i >= size) { return; }
    
    Uint8* RGBA = ptr + (i * 4);
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

    vec3 pixel(u, v, 0.0);
    ray camera_ray(camera.position, camera.direction.add(pixel));
}

void perPixelCalculation(camera& camera, Uint8* scene, unsigned int size, unsigned int width) {
    unsigned int bytes = size * 4;
    Uint8* ptr = nullptr;

    cudaMalloc((void**)&ptr, bytes);
    cudaMemcpy(ptr, scene, bytes, cudaMemcpyHostToDevice);

    unsigned int NUM_THREADS = 1024;
    unsigned int NUM_BLOCKS = (size + NUM_THREADS - 1) / NUM_THREADS;
    kernel <<<NUM_BLOCKS, NUM_THREADS>>> (camera, ptr, size, width);

    cudaMemcpy(scene, ptr, bytes, cudaMemcpyDeviceToHost);
    cudaFree(ptr);
}