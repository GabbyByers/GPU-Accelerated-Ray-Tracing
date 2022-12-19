#ifndef KERNEL_CUH
#define KERNEL_CUH

#include "camera.cuh"

typedef unsigned char Uint8;

Uint8* gpuSetup(Uint8* cpu_ptr, unsigned int size);

void gpuCalc(camera& camera, Uint8* cpu_ptr, Uint8* gpu_ptr, unsigned int width, unsigned int height);

void gpuFree(Uint8* gpu_ptr);

#endif