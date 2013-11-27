#ifndef IDRIS_SDL_RENDER_H
#define IDRIS_SDL_RENDER_H

#include "SDL2/SDL_render.h"
#include "SDL2/SDL_surface.h"
#include "SDL2/SDL_rect.h"

SDL_Renderer* idris_sharedRenderer_renderer();
SDL_Window* idris_sharedWindow_window();

int idris_SDL_createWindowAndRenderer(int width, int height, Uint32 flags);
int idris_SDL_createSoftwareRenderer(SDL_Surface* surface);
int idris_SDL_getRenderer(SDL_Window* window);

int idris_sharedWidth_int();
int idris_sharedHeight_int();
int idris_SDL_getRendererOutputSize(SDL_Renderer* renderer);

SDL_Texture* idris_sharedTexture_texture();
int idris_SDL_createTexture(SDL_Renderer* renderer, Uint32 format, int access, int w, int h);
int idris_SDL_createTextureFromSurface(SDL_Renderer* renderer, SDL_Surface* surface);

int getSharedTextureAccess_int();
Uint32 getSharedFormat_int();
int idris_SDL_queryTexture(SDL_Texture* texture);

Uint8 idris_getRed_uint8();
Uint8 idris_getGreen_uint8();
Uint8 idris_getBlue_uint8();
int idris_SDL_getTextureColorMod(SDL_Texture* texture);
int idris_SDL_getTextureAlphaMod(SDL_Texture* texture);

SDL_BlendMode idris_getBlendMode_mode();
int idris_SDL_getTextureBlendMode(SDL_Texture* texture);

int idris_SDL_updateTexture(SDL_Texture* texture, int x, int y, int w, int h, const void *pixels, int pitch);

#endif /* IDRIS_SDL_RENDER_H */
