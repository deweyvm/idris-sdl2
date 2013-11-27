module SDL.Render

import SDL.Common
import SDL.Video
import SDL.BlendMode
import SDL.Pixels

%include C "SDL2/SDL_render.h"

public
data Renderer = mkRenderer Ptr

public
data Texture = mkTexture Ptr

public
data Color = mkColor Bits8 Bits8 Bits8 Bits8

public
red : Color
red = mkColor 0xFF 0xFF 0xFF 0xFF

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

getSharedWindow : IO Window
getSharedWindow = do
    [| mkWindow (mkForeign (FFun "idris_sharedWindow_window" [] FPtr)) |]

getSharedRenderer : IO Renderer
getSharedRenderer =
    [| mkRenderer (mkForeign (FFun "idris_sharedRenderer_renderer" [] FPtr)) |]

public
CreateWindowAndRenderer : Int -> Int -> List WindowFlag -> IO (Either String (Window, Renderer))
CreateWindowAndRenderer w h flags =
    trySDLRes
        (mkForeign (FFun "idris_SDL_createWindowAndRenderer" [FInt, FInt, FBits32] FInt) w h (sumBits flags))
        [| (/*/) getSharedWindow getSharedRenderer |]

public
CreateRenderer : Window -> Int -> List RendererFlag -> IO Renderer
CreateRenderer (mkWindow win) index flags =
    [| mkRenderer (mkForeign (FFun "SDL_CreateRenderer" [FPtr, FInt, FBits32] FPtr) win index (sumBits flags)) |]

public
CreateSoftwareRenderer : Surface -> IO (Either String Renderer)
CreateSoftwareRenderer (mkSurface surf) =
    trySDLRes
        (mkForeign (FFun "idris_SDL_createSoftwareRenderer" [FPtr] FInt) surf)
        getSharedRenderer

public
GetRenderer : Window -> IO (Either String Renderer)
GetRenderer (mkWindow win) =
    trySDLRes
        (mkForeign (FFun "idris_SDL_getRenderer" [FPtr] FInt) win)
        getSharedRenderer

--extern DECLSPEC int SDLCALL SDL_GetRendererInfo(SDL_Renderer * renderer, SDL_RendererInfo * info);

getWidth : IO Int
getWidth = mkForeign (FFun "idris_sharedWidth_int" [] FInt)

getHeight : IO Int
getHeight = mkForeign (FFun "idris_sharedHeight_int" [] FInt)

public
GetRendererOutputSize : Renderer -> IO (Either String (Int, Int))
GetRendererOutputSize (mkRenderer ren) =
    trySDLRes
        (mkForeign (FFun "idris_SDL_getRendererOutputSize" [FPtr] FInt) ren)
        [| (/*/) getWidth getHeight |]

--extern DECLSPEC SDL_Texture * SDLCALL SDL_CreateTexture(SDL_Renderer * renderer, Uint32 format, int access, int w, int h);

data TextureAccess = TextureAccessStatic
                   | TextureAccessStreaming
                   | TextureAccessTarget

instance Flag Int TextureAccess where
    toFlag TextureAccessStatic    = 0
    toFlag TextureAccessStreaming = 1
    toFlag TextureAccessTarget    = 2

instance Enumerable TextureAccess where
    enumerate = [TextureAccessStatic, TextureAccessStreaming, TextureAccessTarget]

getTexture : IO Texture
getTexture = [| mkTexture (mkForeign (FFun "idris_sharedTexture_texture" [] FPtr)) |]

public
CreateTexture : Renderer -> Bits32 -> TextureAccess -> Int -> Int -> IO (Either String Texture)
CreateTexture (mkRenderer ren) format access w h =
    trySDLRes
        (mkForeign (FFun "idris_SDL_createTexture" [FPtr, FBits32, FInt, FInt, FInt] FInt) ren format (toFlag access) w h)
        getTexture

public
CreateTextureFromSurface : Renderer -> Surface -> IO (Either String Texture)
CreateTextureFromSurface (mkRenderer ren) (mkSurface surf) =
    trySDLRes
        (mkForeign (FFun "idris_SDL_createTextureFromSurface" [FPtr, FPtr] FInt) ren surf)
        getTexture

public
data TextureInfo = mkTextureInfo Bits32 (Maybe TextureAccess) Int Int


getTextureAccess : IO Int
getTextureAccess = mkForeign (FFun "idris_getSharedFormat_int" [] FInt)

getFormat : IO Bits32
getFormat = mkForeign (FFun "idris_getSharedAccess_int" [] FBits32)

public
--extern DECLSPEC int SDLCALL SDL_QueryTexture(SDL_Texture * texture, Uint32 * format, int *access, int *w, int *h);
QueryTexture : Texture -> IO (Either String TextureInfo)
QueryTexture (mkTexture ptr) =
    trySDLRes
        (mkForeign (FFun "idris_SDL_queryTexture" [FPtr] FInt) ptr)
        [| mkTextureInfo getFormat
                         (read `map` getTextureAccess)
                         getWidth
                         getHeight |]

-- | alpha is ignored
public
SetTextureColorMod : Texture -> Color -> IO (Maybe String)
SetTextureColorMod (mkTexture ptr) (mkColor r g b _) =
    trySDL (mkForeign (FFun "SetTextureColorMod" [FPtr, FBits8, FBits8, FBits8] FInt) ptr r g b)

--int SDLCALL SDL_GetTextureColorMod(SDL_Texture * texture, Uint8 * r, Uint8 * g, Uint8 * b);

getRed : IO Bits8
getRed = mkForeign (FFun "idris_getRed_uint8" [] FBits8)

getGreen : IO Bits8
getGreen = mkForeign (FFun "idris_getGreen_uint8" [] FBits8)

getBlue : IO Bits8
getBlue = mkForeign (FFun "idris_getBlue_uint8" [] FBits8)

-- | alpha will be set to 1 always. to get alpha use GetTextureAlphaMod
public
GetTextureColorMod : Texture -> IO (Either String Color)
GetTextureColorMod (mkTexture ptr) =
    trySDLRes
        (mkForeign (FFun "idris_SDL_getTextureColorMod" [FPtr] FInt) ptr)
        [| mkColor getRed
                   getGreen
                   getBlue
                   (return 0xFF) |]

public
--int SDL_SetTextureAlphaMod(SDL_Texture * texture, Uint8 alpha);
SetTextureAlphaMod : Texture -> Bits8 -> IO (Maybe String)
SetTextureAlphaMod (mkTexture ptr) a =
    trySDL (mkForeign (FFun "SDL_SetTextureAlphaMod" [FPtr, FBits8] FInt) ptr a)

getAlpha : IO Bits8
getAlpha = mkForeign (FFun "idris_getAlpha_uint8" [] FBits8)

public
GetTextureAlphaMod : Texture -> IO (Either String Bits8)
GetTextureAlphaMod (mkTexture ptr) =
    trySDLRes
        (mkForeign (FFun "idris_SDL_getTextureAlphaMod" [FPtr] FInt) ptr)
        getAlpha

public
SetTextureBlendMode : Texture -> BlendMode -> IO (Maybe String)
SetTextureBlendMode (mkTexture ptr) mode =
    trySDL (mkForeign (FFun "SDL_SetTextureBlendMode" [FPtr, FBits32] FInt) ptr (toFlag mode))

public
GetTextureBlendMode : Texture -> IO (Either String BlendMode)
GetTextureBlendMode (mkTexture ptr) =
    extract `map` (trySDLRes
        (mkForeign (FFun "idris_SDL_getTextureBlendMode" [FPtr] FInt) ptr)
        (mkForeign (FFun "idris_getBlendMode_mode" [] FBits32))) where
            extract : Either String Bits32 -> Either String BlendMode
            extract e = e >>= ((maybeToEither "Unknown BlendMode") . read)

public
UpdateTexture : Texture -> Rect -> Pixels -> Int -> IO (Maybe String)
UpdateTexture (mkTexture txt) (mkRect x y w h) (mkPixels pix) pitch =
    trySDL (mkForeign (FFun "SDL_UpdateTexture" [FPtr, FInt, FInt, FInt, FInt, FPtr, FInt] FInt) txt x y w h pix pitch)

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
