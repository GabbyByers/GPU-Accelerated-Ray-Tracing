#ifndef KERNEL_CUH
#define KERNEL_CUH

#include "camera.cuh"

typedef unsigned char Uint8;

void perPixelCalculation(camera& camera, Uint8* cpu_ptr, Uint8* gpu_ptr, unsigned int width, unsigned int height);

Uint8* gpuSetup(Uint8* cpu_ptr, unsigned int size);

void theOldFunction(camera& camera, Uint8* cpu_ptr, unsigned int size, unsigned int width);

#endif