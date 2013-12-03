module Graphics.SDL.Error

import Graphics.SDL.Common

%include C "SDL2/SDL_error.h"

public
setError : String -> IO ()
setError str = mkForeign (FFun "SDL_SetError" [FString] FUnit{-ignore output-}) str

private
clearError : IO ()
clearError = mkForeign (FFun "SDL_ClearError" [] FUnit)

-- | Unlike the SDL version, it is more convenient to always clear the error after
--   getting it, but it should be unnecessary to ever call this function manually anyway
public
getError : IO String
getError = do
    result <- mkForeign (FFun "SDL_GetError" [] FString)
    clearError
    return result


