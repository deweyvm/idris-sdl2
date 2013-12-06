#ifndef IDRIS_SDL_SURFACE_H
#define IDRIS_SDL_SURFACE_H

#include "SDL2/SDL_surface.h"
#include "SDL2/SDL_rect.h"

SDL_Surface* idris_getSharedSurface();

int idris_SDL_createRGBSurface(Uint32 flags, int width, int height, int depth,
     Uint32 Rmask, Uint32 Gmask, Uint32 Bmask, Uint32 Amask);
int idris_SDL_createRGBSurfaceFrom(void *pixels, int width, int height, int depth, int pitch, Uint32 Rmask, Uint32 Gmask, Uint32 Bmask, Uint32 Amask);


int idris_makeColorArray(int length);
int idris_colorArrayPush(Uint8 r, Uint8 g, Uint8 b, Uint8 a);
SDL_Color* idris_getColorArray();
void idris_freeColorArray(void* colors);

int idris_SDL_blitSurface(SDL_Surface* src,
                          int sx, int sy, int sw, int sh,
                          SDL_Surface* dst,
                          int dx, int dy, int dw, int dh);

#endif /* IDRIS_SDL_SURFACE_H */
