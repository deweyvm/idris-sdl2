module SDL.Error

import SDL.Common

%include C "SDL2/SDL_error.h"

public
SetError : String -> IO ()
SetError str = mkForeign (FFun "SDL_SetError" [FString] FUnit{-ignore output-}) str

ClearError : IO ()
ClearError = mkForeign (FFun "SDL_ClearError" [] FUnit)

-- | Unlike the SDL version, it is more convenient to always clear the error after
--   getting it, but it should be unnecessary to ever call this function manually anyway
public
GetError : IO String
GetError = do
    result <- mkForeign (FFun "SDL_GetError" [] FString)
    ClearError
    return result


