#ifndef IDRIS_SDL_PIXELS_H
#define IDRIS_SDL_PIXELS_H

#include "SDL2/SDL_stdinc.h"
#include "SDL2/SDL_pixels.h"

int idris_colorArrayCreate(int length);
void idris_colorArrayPush(Uint8 r, Uint8 g, Uint8 b, Uint8 a);
SDL_Color* idris_colorArrayGet();
void idris_colorArrayFree(void* colors);

#endif /* IDRIS_SDL_PIXELS_H */
