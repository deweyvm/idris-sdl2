module SDL.Surface

import SDL.Common
import SDL.Rect

%include C "SDL2/SDL_surface.h"

public
data Surface = mkSurface Ptr

public
data SurfaceFlag = SWSurface
                 | PreAlloc
                 | RLEAccel
                 | DontFree

instance Flag Bits32 SurfaceFlags where
    toFlag SWSurface =  0x00000000
    toFlag PreAlloc  =  0x00000001
    toFlag RLEAccel  =  0x00000002
    toFlag DontFree  =  0x00000004



--SDL_Surface *SDLCALL SDL_CreateRGBSurface
--    (Uint32 flags, int width, int height, int depth,
--     Uint32 Rmask, Uint32 Gmask, Uint32 Bmask, Uint32 Amask);

--public
--CreateRGBSurface : SurfaceFlags -> Int -> Int -> Int -> Bits32 -> Bits32 -> Bits32 -> Bits32
--CreateRGBSurface
public
BlitSurface : Surface -> Rect -> Surface -> Rect -> IO ()
BlitSurface (mkSurface src) (mkRect sx sy sw sh) (mkSurface dst) (mkRect dx dy dw dh) =
    mkForeign (FFun "SDL_BlitSurface" [FPtr, FInt, FInt, FInt, FInt, FPtr, FInt, FInt, FInt, FInt] FUnit) src sx sy sw sh dst dx dy dw dh