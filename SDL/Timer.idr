module SDL.Timer

import SDL.Common

%include C "SDL2/SDL_timer.h"

public
GetTicks : Bits32
GetTicks = unsafePerformIO (mkForeign (FFun "SDL_GetTicks" [] FBits32))

public
GetPerformanceCounter : Bits64
GetPerformanceCounter = unsafePerformIO (mkForeign (FFun "SDL_GetPerformanceCounter" [] FBits64))

public
Delay : Int -> IO ()
Delay ms = mkForeign (FFun "SDL_Delay" [FInt] FUnit) ms
