
#include "idris_SDL_pixels.h"

static SDL_Color* colors;
static int ci = 0;
int idris_colorArrayCreate(int length) {
    colors = malloc(length * sizeof(SDL_Color));
    ci = 0;
    return colors != NULL;
}
void idris_colorArrayPush(Uint8 r, Uint8 g, Uint8 b, Uint8 a) {
    SDL_Color c = {r, g, b, a};
    colors[ci] = c;
}
SDL_Color* idris_colorArrayGet() {
    return colors;
}
void idris_colorArrayFree(void* colors) {
    free(colors);
}

