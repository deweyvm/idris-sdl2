#ifndef IDRIS_SDL_SURFACE_H
#define IDRIS_SDL_SURFACE_H

#include "SDL2/SDL_surface.h"
#include "SDL2/SDL_rect.h"

int idris_SDL_blitSurface(SDL_Surface* src,
                          int sx, int sy, int sw, int sh,
                          SDL_Surface* dst,
                          int dx, int dy, int dw, int dh);

#endif /* IDRIS_SDL_SURFACE_H */
