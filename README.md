# GPU-Accelerated-Ray-Tracing

In this project I use CUDA to calculate the RGB values of every pixel value in an instance of sf::Image.
The image is bound to an instance of sf::Texture and this texture is drawn to a single quad filling the entire window.
Combining CUDA with SFML in this way is a naive approach to achieving what I am trying to implement, but is sufficient for my purposes.
Future projects of this type will use a more appropriate graphics library.

An esoteric issue I came across while developing this application was solved at this link:
https://itecnote.com/tecnote/c-visual-studio-msb3721-error-when-compiling-a-__device__-function-call-from-another-file/
