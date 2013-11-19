module SDL.SDL

import SDL.Common

%include C "SDL2/SDL_error.h"

public
ClearError : IO ()
ClearError = mkForeign (FFun "SDL_ClearError" [] FUnit)

public
GetError : IO String
GetError = do
    result <- mkForeign (FFun "SDL_GetError" [] FString)
    ClearError
    return result
    
public
Init : Int -> IO Int
Init flag =  mkForeign (FFun "SDL_Init" [FInt] FInt) flag

