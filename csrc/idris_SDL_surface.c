#include "idris_SDL_surface.h"

static SDL_Surface* surface;

SDL_PixelFormat idris_surfaceGetFormat(SDL_Surface* surface) {
    return *(surface->format);
}


SDL_Surface* idris_getSharedSurface() {
    return surface;
}

int idris_SDL_createRGBSurface(Uint32 flags, int width, int height, int depth, Uint32 Rmask, Uint32 Gmask, Uint32 Bmask, Uint32 Amask) {
    surface = SDL_CreateRGBSurface(flags, width, height, depth, Rmask, Gmask, Bmask, Amask);
    return surface != NULL;
}

int idris_SDL_createRGBSurfaceFrom(void *pixels, int width, int height, int depth, int pitch, Uint32 Rmask, Uint32 Gmask, Uint32 Bmask, Uint32 Amask) {
    surface = SDL_CreateRGBSurfaceFrom(pixels, width, height, depth, pitch, Rmask, Gmask, Bmask, Amask);
    return surface != NULL;
}



int idris_SDL_blitSurface(SDL_Surface* src,
                           int sx, int sy, int sw, int sh,
                           SDL_Surface* dst,
                           int dx, int dy, int dw, int dh) {
    SDL_Rect srcrect = { sx, sy, sw, sh };
    SDL_Rect dstrect = { dx, dy, dw, dh };

    return 0 == SDL_BlitSurface(src, &srcrect, dst, &dstrect);
}

int idris_SDL_loadBMP(const char* file) {
    surface = SDL_LoadBMP(file);
    return surface != NULL;
}

SDL_Surface* idris_SDL_loadBMP_surface() {
    return surface;
}

int idris_SDL_saveBMP(SDL_Surface* surface, const char* file) {
    return 0 != SDL_SaveBMP(surface, file);
}
