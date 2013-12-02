#include "idris_SDL_surface.h"

int idris_SDL_blitSurface(SDL_Surface* src,
                           int sx, int sy, int sw, int sh,
                           SDL_Surface* dst,
                           int dx, int dy, int dw, int dh) {
    struct SDL_Rect srcrect = { sx, sy, sw, sh };
    struct SDL_Rect dstrect = { dx, dy, dw, dh };

    return 0 == SDL_BlitSurface(src, &srcrect, dst, &dstrect);
}
