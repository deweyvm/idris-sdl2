#include "idris_SDL_mouse.h"

static int x;
static int y;
static Uint32 getMouseState_state;

void idris_SDL_getMouseState() {
    getMouseState_state = SDL_GetMouseState(&x, &y);
}

int idris_sharedX_int() {
    return x;
}

int idris_sharedY_int() {
    return y;
}

Uint32 idris_SDL_getMouseState_state() {
    return getMouseState_state;
}

static Uint32 getRelativeMouseState_state;

void idris_SDL_getRelativeMouseState() {
    getRelativeMouseState_state = SDL_GetRelativeMouseState(&x, &y);
}

Uint32 idris_SDL_getRelativeMouseState_state() {
    return getRelativeMouseState_state;
}

static SDL_Cursor* cursor;
SDL_Cursor* idris_sharedCursor() {
    return cursor;
}

int idris_SDL_createCursor(const Uint8 * data, const Uint8 * mask, int w, int h, int hot_x, int hot_y) {
    cursor = SDL_CreateCursor(data, mask, w, h, hot_x, hot_y);
    return cursor != NULL;
}

int idris_SDL_createColorCursor(SDL_Surface* surface, int hot_x, int hot_y) {
    cursor = SDL_CreateColorCursor(surface, hot_x, hot_y);
    return cursor != NULL;
}

int idris_SDL_createSystemCursor(SDL_SystemCursor id) {
    cursor = SDL_CreateSystemCursor(id);
    return cursor != NULL;
}

int idris_SDL_getCursor() {
    cursor = SDL_GetCursor();
    return cursor != 0;
}

int idris_SDL_getDefaultCursor() {
    cursor = SDL_GetDefaultCursor();
    return cursor != 0;
}
