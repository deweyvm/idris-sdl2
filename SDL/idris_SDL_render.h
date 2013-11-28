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


int idris_SDL_getRendererInfo(SDL_Renderer* renderer);
char* idris_rendererInfo_name();
Uint32 idris_rendererInfo_flags();
int idris_rendererInfo_hasTextureFormat();
Uint32 idris_rendererInfo_getTextureFormat();
int idris_rendererInfo_max_texture_width();
int idris_rendererInfo_max_texture_height();

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

int idris_SDL_lockTexture(SDL_Texture * texture, int x, int y, int w, int h);
void* idris_getPixels() ;
int idris_getPitch();

int idris_SDL_getRenderTarget(SDL_Renderer* renderer);
SDL_Texture* idris_sharedTexture();

void idris_SDL_renderGetLogicalSize(SDL_Renderer* renderer);
int idris_SDL_renderSetViewport(SDL_Renderer* renderer, int x, int y, int w, int h);

int idris_render_sharedX_int();
int idris_render_sharedY_int();
void idris_SDL_renderGetViewport(SDL_Renderer* renderer);
int idris_SDL_renderSetClipRect(SDL_Renderer* renderer, int x, int y, int w, int h);
void idris_SDL_renderGetClipRect(SDL_Renderer* renderer);
void idris_SDL_renderGetScale(SDL_Renderer* renderer);
#endif /* IDRIS_SDL_RENDER_H */
