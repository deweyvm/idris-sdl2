
#include "idris_SDL_pixels.h"

static int bpp;
static Uint32 Rmask;
static Uint32 Gmask;
static Uint32 Bmask;
static Uint32 Amask;

int idris_SDL_pixelFormatEnumToMasks(Uint32 format) {
    return SDL_PixelFormatEnumToMasks(format, &bpp, &Rmask, &Gmask, &Bmask, &Amask);
}

int idris_SDL_pixelFormatEnumToMasks_bpp() {
    return bpp;
}
Uint32 idris_SDL_pixelFormatEnumToMasks_Rmask() {
    return Rmask;
}
Uint32 idris_SDL_pixelFormatEnumToMasks_Gmask() {
    return Gmask;
}
Uint32 idris_SDL_pixelFormatEnumToMasks_Bmask() {
    return Bmask;
}
Uint32 idris_SDL_pixelFormatEnumToMasks_Amask() {
    return Amask;
}

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

Uint32 idris_SDL_mapRGB(SDL_PixelFormat format, Uint8 r, Uint8 g, Uint8 b) {
    return SDL_MapRGB(&format, r, g, b);
}
Uint32 idris_SDL_mapRGBA(SDL_PixelFormat format, Uint8 r, Uint8 g, Uint8 b, Uint8 a) {
    return SDL_MapRGBA(&format, r, g, b, a);
}

static Uint8 r;
static Uint8 g;
static Uint8 b;
static Uint8 a;

void idris_SDL_getRGB(Uint32 pixel, const SDL_PixelFormat* format) {
    SDL_GetRGB(pixel, format, &r, &g, &b);
}
Uint8 idris_SDL_getRGB_r() {
    return r;
}
Uint8 idris_SDL_getRGB_g() {
    return g;
}
Uint8 idris_SDL_getRGB_b() {
    return b;
}

void idris_SDL_getRGBA(Uint32 pixel, const SDL_PixelFormat* format) {
    SDL_GetRGBA(pixel, format, &r, &g, &b, &a);
}
Uint8 idris_SDL_getRGBA_a() {
    return a;
}


Uint16 idris_SDL_calculateGammaRamp(float gamma) {
    Uint16 retval;
    SDL_CalculateGammaRamp(gamma, &retval);
    return retval;
}
