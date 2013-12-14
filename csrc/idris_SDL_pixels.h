#ifndef IDRIS_SDL_PIXELS_H
#define IDRIS_SDL_PIXELS_H

#include "SDL2/SDL_stdinc.h"
#include "SDL2/SDL_pixels.h"

int idris_SDL_pixelFormatEnumToMasks(Uint32 format);

int idris_SDL_pixelFormatEnumToMasks_bpp();
Uint32 idris_SDL_pixelFormatEnumToMasks_Rmask();
Uint32 idris_SDL_pixelFormatEnumToMasks_Gmask();
Uint32 idris_SDL_pixelFormatEnumToMasks_Bmask();
Uint32 idris_SDL_pixelFormatEnumToMasks_Amask();

int idris_paletteCreate(int length);
void idris_palettePush(Uint8 r, Uint8 g, Uint8 b, Uint8 a);
SDL_Palette* idris_paletteGet();
void idris_paletteFree(void* colors);

Uint32 idris_SDL_mapRGB(SDL_PixelFormat format, Uint8 r, Uint8 g, Uint8 b);
Uint32 idris_SDL_mapRGBA(SDL_PixelFormat format, Uint8 r, Uint8 g, Uint8 b, Uint8 a);

void idris_SDL_getRGB(Uint32 pixel, const SDL_PixelFormat* format);
Uint8 idris_SDL_getRGB_r();
Uint8 idris_SDL_getRGB_g();
Uint8 idris_SDL_getRGB_b();


void idris_SDL_getRGBA(Uint32 pixel, const SDL_PixelFormat* format);
Uint8 idris_SDL_getRGB_a();

Uint16 idris_SDL_calculateGammaRamp(float gamma);

#endif /* IDRIS_SDL_PIXELS_H */
