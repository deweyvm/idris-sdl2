module Graphics.SDL.Surface

import Graphics.SDL.Common
import Graphics.SDL.Rect

%include C "SDL2/SDL_surface.h"
%include C "csrc/idris_SDL_surface.h"
%link C "idris_SDL_surface.o"

public
data Surface = MkSurface Ptr

public
data SurfaceFlag = SWSurface
                 | PreAlloc
                 | RLEAccel
                 | DontFree

instance Flag Bits32 SurfaceFlag where
    toFlag SWSurface =  0x00000000
    toFlag PreAlloc  =  0x00000001
    toFlag RLEAccel  =  0x00000002
    toFlag DontFree  =  0x00000004



getSharedSurface : IO Surface
getSharedSurface =
    [| MkSurface (mkForeign (FFun "idris_getSharedSurface" [] FPtr)) |]

public
createRGBSurface : List SurfaceFlag -> Int -> Int -> Int -> Bits32 -> Bits32 -> Bits32 -> Bits32 -> IO (Either String Surface)
createRGBSurface flags w h depth r g b a =
    doSDLIf
        (mkForeign (FFun "idris_SDL_createRGBSurface" [FBits32, FInt, FInt, FInt, FBits32, FBits32, FBits32, FBits32] FInt) (sumBits flags) w h depth r g b a)
        getSharedSurface

public
createRGBSurfaceFrom : Pixels -> Int -> Int -> Int -> Int -> Bits32 -> Bits32 -> Bits32 -> Bits32 -> IO (Either String Surface)
createRGBSurfaceFrom (MkPixels pix) w h d pitch r g b a =
    doSDLIf
        (mkForeign (FFun "idris_SDL_createRGBSurfaceFrom" [FPtr, FInt, FInt, FInt, FInt, FBits32, FBits32, FBits32, FBits32] FInt) pix w h d pitch r g b a)
        getSharedSurface

public
freeSurface : Surface -> IO ()
freeSurface (MkSurface surf) =
    mkForeign (FFun "SDL_FreeSurface" [FPtr] FUnit) surf

public
setSurfacePalette : Surface -> Palette -> IO (Maybe String)
setSurfacePalette (MkSurface surf) (MkPalette pal) =
    doSDL (mkForeign (FFun "SDL_SetSurfacePalette" [FPtr, FPtr] FInt) surf pal)

public
lockSurface : Surface -> IO (Maybe String)
lockSurface (MkSurface surf) =
    doSDL (mkForeign (FFun "SDL_LockSurface" [FPtr] FInt) surf)

public
unlockSurface : Surface -> IO ()
unlockSurface (MkSurface surf) =
    mkForeign (FFun "SDL_UnlockSurface" [FPtr] FUnit) surf

public
loadBMP : String -> IO (Either String Surface)
loadBMP file =
    doSDLIf
        (mkForeign (FFun "idris_SDL_loadBMP" [FString] FInt) file)
        [| MkSurface (mkForeign (FFun "idris_SDL_loadBMP_surface" [] FPtr)) |]

public
saveBMP : Surface -> String -> IO (Maybe String)
saveBMP (MkSurface surf) filename =
    doSDL (mkForeign (FFun "idris_SDL_saveBMP" [FPtr, FString] FInt) surf filename)

--setSurfaceRLE : Surface -> Int -> IO (Maybe String)
--setSurfaceRLE (MkSurface
--    doSDL (mkForeign (FFun "SDL_SetSurfaceRLE" [FPtr, FInt

public
blitSurface : Surface -> Rect -> Surface -> Rect -> IO (Maybe String)
blitSurface (MkSurface src) (MkRect sx sy sw sh) (MkSurface dst) (MkRect dx dy dw dh) =
    doSDL (mkForeign (FFun "SDL_BlitSurface" [FPtr, FInt, FInt, FInt, FInt, FPtr, FInt, FInt, FInt, FInt] FInt) src sx sy sw sh dst dx dy dw dh)

