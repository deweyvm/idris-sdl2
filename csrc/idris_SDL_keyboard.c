#include "idris_SDL_keyboard.h"

static SDL_Window* window;
int idris_SDL_getKeyboardFocus() {
    window = SDL_GetKeyboardFocus();
    return window != NULL;
}
SDL_Window* idris_SDL_getKeyboardFocus_window() {
    return window;
}

static Uint8* keys;
static int length;
static int i;
int idris_SDL_getKeyboardState() {
    i = 0;
    return 0 == SDL_GetKeyboardState(&length);
}

int idris_getKeyboardState_length() {
    return length;
}

Uint8 idris_getKeyboardState_keystate(int i) {
    return keys[i++];
}

void idris_SDL_setTextInputRect(int x, int y, int w, int h) {
    SDL_Rect rect = {x, y, w, h};
    SDL_SetTextInputRect(&rect);
}
