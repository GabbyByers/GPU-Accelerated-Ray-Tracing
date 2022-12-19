#ifndef KERNEL_CUH
#define KERNEL_CUH

#include "camera.cuh"
#include "Enviroment.cuh"
#include <iostream>
using std::cout;

typedef unsigned char Uint8;

Uint8* gpuSetup(Uint8* cpu_ptr, unsigned int size);

void gpuCalc(Enviroment& enviroment, camera& camera, Uint8* cpu_ptr, Uint8* gpu_ptr, unsigned int width, unsigned int height);

void gpuFree(Uint8* gpu_ptr);

#endif