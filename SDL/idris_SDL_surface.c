#include "idris_SDL_surface.h"

void idris_SDL_blitSurface(SDL_Surface* src,
                           int sx, int sy, int sw, int sh,
                           SDL_Surface* dst,
                           int dx, int dy, int dw, int dh) {
    struct SDL_Rect srcrect;
    srcrect.x = sx;
    srcrect.y = sy;
    srcrect.w = sw;
    srcrect.h = sh;

    struct SDL_Rect dstrect;
    dstrect.x = dx;
    dstrect.y = dy;
    dstrect.w = dw;
    dstrect.h = dh;

    SDL_BlitSurface(src, &srcrect, dst, &dstrect);
}