#include "idris_SDL_surface.h"

static SDL_Surface* surface;

SDL_Surface* idris_getSharedSurface() {
    return surface;
}

int idris_SDL_createRGBSurface(Uint32 flags, int width, int height, int depth, Uint32 Rmask, Uint32 Gmask, Uint32 Bmask, Uint32 Amask) {
    surface = SDL_CreaceRGBSurface(flags, width, height, depth, Rmask, Gmask, Bmask, Amask);
    return surface != NULL;
}


int idris_SDL_blitSurface(SDL_Surface* src,
                           int sx, int sy, int sw, int sh,
                           SDL_Surface* dst,
                           int dx, int dy, int dw, int dh) {
    struct SDL_Rect srcrect = { sx, sy, sw, sh };
    struct SDL_Rect dstrect = { dx, dy, dw, dh };

    return 0 == SDL_BlitSurface(src, &srcrect, dst, &dstrect);
}
