module SDL.GameController

import SDL.Common

%include C "SDL2/SDL_gamecontroller.h"

public
GameControllerAddMapping : IO (Maybe String)
GameControllerAddMapping = do
    trySDL (mkForeign (FFun "SDL_GameControllerAddMapping" [] FInt))