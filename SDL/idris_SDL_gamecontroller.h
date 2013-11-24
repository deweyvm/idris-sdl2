#ifndef IDRIS_SDL_GAMECONTROLLER_H
#define IDRIS_SDL_GAMECONTROLLER_H

#include "SDL2/SDL_gamecontroller.h"

const char* idris_gameController_sharedString_string();
void idris_gameController_sharedString_free();

int idris_SDL_gameControllerMappingForGUID(Uint8 guid[16]);
int idris_SDL_gameControllerMapping(SDL_GameController* gamecontroller);
int idris_SDL_gameControllerNameForIndex(int joystick_index);
SDL_GameController* idris_sharedGameController_controller();
int idris_SDL_gameControllerOpen(int joystick_index);

#endif /* IDRIS_SDL_GAMECONTROLLER_H */
