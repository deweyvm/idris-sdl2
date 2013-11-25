module SDL.SDL

import SDL.Common
import SDL.Error

%include C "SDL2/SDL.h"


{-
    Not implemented:
        SDL_assert.h
        SDL_atomic.h - use idris's concurrency
        SDL_config.h - SDL internal stuff
        SDL_endian.h

-}

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

