#ifndef IDRIS_SDL_SURFACE_H
#define IDRIS_SDL_SURFACE_H

#include "SDL2/SDL_surface.h"
#include "SDL2/SDL_rect.h"

SDL_PixelFormat idris_surfaceGetFormat(SDL_Surface* surface);

SDL_Surface* idris_getSharedSurface();

int idris_SDL_createRGBSurface(Uint32 flags, int width, int height, int depth,
     Uint32 Rmask, Uint32 Gmask, Uint32 Bmask, Uint32 Amask);
int idris_SDL_createRGBSurfaceFrom(void *pixels, int width, int height, int depth, int pitch, Uint32 Rmask, Uint32 Gmask, Uint32 Bmask, Uint32 Amask);


int idris_SDL_blitSurface(SDL_Surface* src,
                          int sx, int sy, int sw, int sh,
                          SDL_Surface* dst,
                          int dx, int dy, int dw, int dh);

int idris_SDL_loadBMP(const char* file);
SDL_Surface* idris_SDL_loadBMP_surface();

int idris_SDL_saveBMP(SDL_Surface* surface, const char* file);

#endif /* IDRIS_SDL_SURFACE_H */
