module SDL.SDL

import SDL.Common


public
Init : Int -> IO Int
Init flag =  mkForeign (FFun "SDL_Init" [FInt] FInt) flag

