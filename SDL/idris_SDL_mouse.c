#include "idris_SDL_mouse.h"



int getMouseState_x;
int getMouseState_y;
Uint32 getMouseState_state;

void idris_SDL_GetMouseState() {
  getMouseState_state = SDL_GetMouseState(&getMouseState_x,
					  &getMouseState_y);
}

int idris_SDL_GetMouseState_x() {
  return getMouseState_x;
}

int idris_SDL_GetMouseState_y() {
  return getMouseState_y;
}

Uint32 idris_SDL_GetMouseState_state() {
  return getMouseState_state;
}

int getRelativeMouseState_x;
int getRelativeMouseState_y;
Uint32 getRelativeMouseState_state;

void idris_SDL_GetRelativeMouseState() {
  getRelativeMouseState_state = 
    SDL_GetRelativeMouseState(&getRelativeMouseState_x,
			      &getRelativeMouseState_y);
}

int idris_SDL_GetRelativeMouseState_x() {
  return getRelativeMouseState_x;
}

int idris_SDL_GetRelativeMouseState_y() {
  return getRelativeMouseState_y;
}

Uint32 idris_SDL_GetRelativeMouseState_state() {
  return getRelativeMouseState_state;
}


int idris_SDL_setRelativeMouseMode(int b) {
  return SDL_SetRelativeMouseMode(b);
}
