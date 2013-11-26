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
data InitFlag = InitTimer
              | InitAudio
              | InitVideo
              | InitJoystick
              | InitHaptic
              | InitGameController
              | InitEvents
              | InitNoParachute
              | InitEverything

instance Flag Bits32 InitFlag where
    toFlag InitTimer          = 0x00000001
    toFlag InitAudio          = 0x00000010
    toFlag InitVideo          = 0x00000020
    toFlag InitJoystick       = 0x00000200
    toFlag InitHaptic         = 0x00001000
    toFlag InitGameController = 0x00002000
    toFlag InitEvents         = 0x00004000
    toFlag InitNoParachute    = 0x00100000
    toFlag InitEverything     = 0x00001C3F

public
Init : List InitFlag -> IO (Maybe String)
Init flags = do
    trySDL (mkForeign (FFun "SDL_Init" [FBits32] FInt) (sumBits flags))

public
InitSubSystem : List InitFlag -> IO (Maybe String)
InitSubSystem flags = do
    trySDL (mkForeign (FFun "SDL_InitSubSystem" [FBits32] FInt) (sumBits flags))

public
QuitSubSystem : List InitFlag -> IO ()
QuitSubSystem flags = do
    mkForeign (FFun "SDL_QuitSubSystem" [FBits32] FUnit) (sumBits flags)

public
Quit : IO ()
Quit = mkForeign (FFun "SDL_Quit" [] FUnit)
