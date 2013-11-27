#include "idris_SDL_render.h"

static SDL_Window* window;
static SDL_Renderer* renderer;

int idris_SDL_createWindowAndRenderer(int width, int height, Uint32 flags) {
    return SDL_CreateWindowAndRenderer(width, height, flags,
                                       &window, &renderer);

}

SDL_Renderer* idris_sharedWindowAndRenderer_renderer() {
    return renderer;
}

SDL_Window* idris_sharedWindowAndRenderer_window() {
    return window;
}
