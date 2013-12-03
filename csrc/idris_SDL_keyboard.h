#ifndef IDRIS_SDL_KEYBOAD_h
#define IDRIS_SDL_KEYBOAD_h

#include "SDL2/SDL_keyboard.h"

int idris_SDL_getKeyboardFocus();
SDL_Window* idris_SDL_getKeyboardFocus_window();

int idris_SDL_getKeyboardState();
int idris_getKeyboardState_length();
Uint8 idris_getKeyboardState_keystate(int i);

void idris_SDL_setTextInputRect(int x, int y, int w, int h);

#endif /* IDRIS_SDL_KEYBOAD_h */
