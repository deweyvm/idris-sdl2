module SDL.Timer

import SDL.Common

%include C "SDL2/SDL_timer.h"

public
GetTicks : IO Bits32
GetTicks = mkForeign (FFun "SDL_GetTicks" [] FBits32)

public
GetPerformanceCounter : IO Bits64
GetPerformanceCounter = mkForeign (FFun "SDL_GetPerformanceCounter" [] FBits64)

public
GetPerformanceFrequency : IO Bits64
GetPerformanceFrequency = mkForeign (FFun "SDL_GetPerformanceFrequency" [] FBits64)

public
Delay : Int -> IO ()
Delay ms = mkForeign (FFun "SDL_Delay" [FInt] FUnit) ms

--timers/timer callbacks not implemented. use idris's concurrency?
