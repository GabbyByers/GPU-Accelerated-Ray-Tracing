#ifndef KERNEL_CUH
#define KERNEL_CUH

#include "camera.cuh"

typedef unsigned char Uint8;
void perPixelCalculation(camera& camera, Uint8* scene, unsigned int width, unsigned int height);

#endif