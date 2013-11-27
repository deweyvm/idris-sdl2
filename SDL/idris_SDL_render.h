#ifndef IDRIS_SDL_RENDER_H
#define IDRIS_SDL_RENDER_H

#include "SDL2/SDL_render.h"

int idris_SDL_createWindowAndRenderer(int width, int height, Uint32 flags);
SDL_Renderer* idris_sharedWindowAndRenderer_renderer();
SDL_Window* idris_sharedWindowAndRenderer_window();
#endif /* IDRIS_SDL_RENDER_H */
