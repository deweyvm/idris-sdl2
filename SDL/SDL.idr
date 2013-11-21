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
Init : Int -> IO (Maybe String)
Init flags = do
    success <- mkForeign (FFun "SDL_Init" [FInt] FInt) flags
    if (success /= 0)
      then do
        errorString <- GetError
        return $ Just errorString
      else do
        return Nothing

