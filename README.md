# GPU-Accelerated-Ray-Tracing

In this project I use CUDA to calculate the RGB values of every pixel value in an instance of sf::Image.
The image is bound to an instance of sf::Texture and this texture is drawn to a single quad filling the entire window.
Combining CUDA with SFML in this way is a naive approach to achieving what I am trying to implement, but is sufficient for my purposes.
Some day I will learn to use a more appropriate graphics library.

An esoteric issue I came across while developing this application was solved at this link:
https://itecnote.com/tecnote/c-visual-studio-msb3721-error-when-compiling-a-__device__-function-call-from-another-file/

not broken link:
https://stackoverflow.com/questions/45258052/visual-studio-msb3721-error-when-compiling-a-device-function-call-from-anoth

![image](https://github.com/user-attachments/assets/1e4a4674-7d78-4ebb-908e-cfc8f3c06577)
