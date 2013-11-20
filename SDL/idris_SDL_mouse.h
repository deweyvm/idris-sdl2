#ifndef IDRIS_SDL_MOUSE_H
#define IDRIS_SDL_MOUSE_H
#include "SDL2/SDL_video.h"
#include "SDL2/SDL_mouse.h"

Uint32 idris_SDL_GetMouseState_state();
int idris_SDL_GetMouseState_x();
int idris_SDL_GetMouseState_y();

Uint32 idris_SDL_GetRelativeMouseState_state();
int idris_SDL_GetRelativeMouseState_x();
int idris_SDL_GetRelativeMouseState_y();

#endif /* IDRIS_SDL_MOUSE_H */
