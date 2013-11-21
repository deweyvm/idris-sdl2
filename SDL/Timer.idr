module SDL.Timer

import SDL.Common

%include C "SDL2/SDL_timer.h"

public
Delay : Int -> IO ()
Delay ms = mkForeign (FFun "SDL_Delay" [FInt] FUnit) ms