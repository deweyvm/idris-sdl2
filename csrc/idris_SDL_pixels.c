
#include "idris_SDL_pixels.h"

static SDL_Palette* palette;
static SDL_Color* colors;
static int ci = 0;
int idris_paletteCreate(int length) {
    colors = malloc(length * sizeof(SDL_Color));
    palette = SDL_AllocPalette(length);
    ci = 0;
    return colors != NULL;
}
void idris_palettePush(Uint8 r, Uint8 g, Uint8 b, Uint8 a) {
    SDL_Color c = {r, g, b, a};
    colors[ci] = c;
}
SDL_Palette* idris_paletteGet() {
    return colors;
}
void idris_paletteFree(void* colors) {
    free(colors);
}

