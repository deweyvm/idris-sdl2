#ifndef IDRIS_SDL_MOUSE_H
#define IDRIS_SDL_MOUSE_H

#include "SDL2/SDL_video.h"
#include "SDL2/SDL_mouse.h"

int idris_sharedX_int();
int idris_sharedY_int();
Uint32 idris_getMouseState_state();
Uint32 idris_SDL_getRelativeMouseState_state();

SDL_Cursor* idris_sharedCursor();
int idris_SDL_createCursor(const Uint8* data, const Uint8* mask, int w, int h, int hot_x, int hot_y);
int idris_SDL_createColorCursor(SDL_Surface* surface, int hot_x, int hot_y);
int idris_SDL_createSystemCursor(SDL_SystemCursor id);
int idris_SDL_getCursor();
int idris_SDL_getDefaultCursor();
#endif /* IDRIS_SDL_MOUSE_H */
