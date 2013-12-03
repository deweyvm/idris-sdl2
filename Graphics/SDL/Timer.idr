module Graphics.SDL.Timer

import Graphics.SDL.Common

%include C "SDL2/SDL_timer.h"

public
getTicks : IO Bits32
getTicks = mkForeign (FFun "SDL_GetTicks" [] FBits32)

public
getPerformanceCounter : IO Bits64
getPerformanceCounter = mkForeign (FFun "SDL_GetPerformanceCounter" [] FBits64)

public
getPerformanceFrequency : IO Bits64
getPerformanceFrequency = mkForeign (FFun "SDL_GetPerformanceFrequency" [] FBits64)

public
delay : Int -> IO ()
delay ms = mkForeign (FFun "SDL_Delay" [FInt] FUnit) ms

--timers/timer callbacks not implemented. use idris's concurrency?
