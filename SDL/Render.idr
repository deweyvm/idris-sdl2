module SDL.Render

import SDL.Common
import SDL.Video

%include C "SDL2/SDL_render.h"

public
data Renderer = mkRenderer Ptr

public
data Color = mkColor Bits8 Bits8 Bits8 Bits8

public
red : Color
red = mkColor 0xff 0xff 0xff 0xff

public
data RendererFlag = RendererSoftware
                  | RendererAccelerated
                  | RendererPresentVSync
                  | RendererTargetTexture

instance Flag Bits32 RendererFlag where
   toFlag RendererSoftware      = 0x00000001
   toFlag RendererAccelerated   = 0x00000002
   toFlag RendererPresentVSync  = 0x00000004
   toFlag RendererTargetTexture = 0x00000008

instance Enumerable RendererFlag where
    enumerate = [RendererSoftware, RendererAccelerated, RendererPresentVSync, RendererTargetTexture]

public
GetNumRenderDrivers : IO Int
GetNumRenderDrivers = mkForeign (FFun "SDL_GetNumRenderDrivers" [] FInt)

--extern DECLSPEC int SDLCALL SDL_GetRenderDriverInfo(int index, SDL_RendererInfo * info);

createWindowAndRenderer_window : IO Window
createWindowAndRenderer_window = do
    [| mkWindow (mkForeign (FFun "idris_sharedWindowAndRenderer_window" [] FPtr)) |]

createWindowAndRenderer_renderer : IO Renderer
createWindowAndRenderer_renderer =
    [| mkRenderer (mkForeign (FFun "idris_sharedWindowAndRenderer_renderer" [] FPtr)) |]

CreateWindowAndRenderer : Int -> Int -> List WindowFlag -> IO (Either String (Window, Renderer))
CreateWindowAndRenderer w h flags =
    trySDLRes
        (mkForeign (FFun "idris_SDL_createWindowAndRenderer" [FInt, FInt, FBits32] FInt) w h (sumBits flags))
        [| (/*/) createWindowAndRenderer_window createWindowAndRenderer_renderer |]

public
CreateRenderer : Window -> Int -> List RendererFlag -> IO Renderer
CreateRenderer (mkWindow win) index flags =
    [| mkRenderer (mkForeign (FFun "SDL_CreateRenderer" [FPtr, FInt, FBits32] FPtr) win index (sumBits flags)) |]

public
RenderDrawLine : Renderer -> Int -> Int -> Int -> Int -> IO (Maybe String)
RenderDrawLine (mkRenderer ren) x1 y1 x2 y2 =
    trySDL (mkForeign (FFun "SDL_RenderDrawLine" [FPtr, FInt, FInt, FInt, FInt] FInt) ren x1 y1 x2 y2)

public
SetRenderDrawColor : Renderer -> Color -> IO (Maybe String)
SetRenderDrawColor (mkRenderer ren) (mkColor r g b a) =
    trySDL (mkForeign (FFun "SDL_SetRenderDrawColor" [FPtr, FBits8, FBits8, FBits8, FBits8] FInt) ren r g b a)

public
RenderPresent : Renderer -> IO ()
RenderPresent (mkRenderer ren) =
    mkForeign (FFun "SDL_RenderPresent" [FPtr] FUnit) ren

public
RenderClear : Renderer -> IO ()
RenderClear (mkRenderer ren) =
    mkForeign (FFun "SDL_RenderClear" [FPtr] FUnit) ren
