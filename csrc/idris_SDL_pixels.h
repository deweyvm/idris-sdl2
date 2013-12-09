#ifndef IDRIS_SDL_PIXELS_H
#define IDRIS_SDL_PIXELS_H

#include "SDL2/SDL_stdinc.h"
#include "SDL2/SDL_pixels.h"

int idris_paletteCreate(int length);
void idris_palettePush(Uint8 r, Uint8 g, Uint8 b, Uint8 a);
SDL_Palette* idris_paletteGet();
void idris_paletteFree(void* colors);

#endif /* IDRIS_SDL_PIXELS_H */
