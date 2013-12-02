#include "idris_SDL_gamecontroller.h"

static char* sharedString_string;

const char* idris_gameController_sharedString_string() {
    return sharedString_string;
}

void idris_gameController_sharedString_free() {
    SDL_free(sharedString_string);
    sharedString_string = NULL;
}

int idris_SDL_gameControllerMappingForGUID(Uint8* guid) {
    SDL_JoystickGUID g;// = (void*)guid;
    sharedString_string = SDL_GameControllerMappingForGUID(g);
    return sharedString_string != NULL;
}

int idris_SDL_gameControllerMapping(SDL_GameController* gamecontroller) {
    sharedString_string = SDL_GameControllerMapping(gamecontroller);
    return sharedString_string != NULL;
}

int idris_SDL_gameControllerNameForIndex(int joystick_index) {
    sharedString_string = SDL_GameControllerNameForIndex(joystick_index);
    return sharedString_string != NULL;
}

static SDL_GameController* idris_sharedGameController;
int idris_SDL_gameControllerOpen(int joystick_index) {
    idris_sharedGameController = SDL_GameControllerOpen(joystick_index);
    return idris_sharedGameController != NULL;
}

SDL_GameController* idris_sharedGameController_controller() {
    return idris_sharedGameController;
}
