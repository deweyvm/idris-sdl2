module Graphics.SDL.SDL

import Graphics.SDL.Common
import Graphics.SDL.Error

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

instance Enumerable InitFlag where
    enumerate = [InitTimer, InitAudio, InitVideo, InitJoystick, InitHaptic, InitGameController, InitEvents, InitNoParachute]

instance Show InitFlag where
    show InitTimer = "InitTimer"
    show InitAudio = "InitAudio"
    show InitVideo = "InitVideo"
    show InitJoystick = "InitJoystick"
    show InitHaptic = "InitHaptic"
    show InitGameController = "InitGameController"
    show InitEvents = "InitEvents"
    show InitNoParachute = "InitNoParachute"
    show InitEverything = "InitEverything"

public
Init : List InitFlag -> IO (Maybe String)
Init flags = do
    doSDL ((\x => 1 - x) `map` (mkForeign (FFun "SDL_Init" [FBits32] FInt) (sumBits flags)))

public
InitSubSystem : List InitFlag -> IO (Maybe String)
InitSubSystem flags = do
    doSDL (mkForeign (FFun "SDL_InitSubSystem" [FBits32] FInt) (sumBits flags))

--for the C behavior when passing 0, use GetInit
public
WasInit : InitFlag -> IO Bool
WasInit flag = do
    bits <- mkForeign (FFun "SDL_WasInit" [FBits32] FBits32) (toFlag flag)
    return (bits == (toFlag flag))

--note: does not show parachute status
public
GetInit : IO (List InitFlag)
GetInit = do
    initialized <- mkForeign (FFun "SDL_WasInit" [FBits32] FBits32) 0x0
    return $ bitMaskToFlags initialized

public
QuitSubSystem : List InitFlag -> IO ()
QuitSubSystem flags = do
    mkForeign (FFun "SDL_QuitSubSystem" [FBits32] FUnit) (sumBits flags)

public
Quit : IO ()
Quit = mkForeign (FFun "SDL_Quit" [] FUnit)
