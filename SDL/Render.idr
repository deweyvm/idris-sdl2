module SDL.Render

import SDL.Common
import SDL.Video
import SDL.BlendMode
import SDL.Pixels

%include C "SDL2/SDL_render.h"
%include C "SDL/idris_SDL_render.h"
%link C "idris_SDL_render.o"

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

instance Show RendererFlag where
    show RendererSoftware      = "RendererSoftware"
    show RendererAccelerated   = "RendererAccelerated"
    show RendererPresentVSync  = "RendererPresentVSync"
    show RendererTargetTexture = "RendererTargetTexture"

instance Enumerable RendererFlag where
    enumerate = [RendererSoftware, RendererAccelerated, RendererPresentVSync, RendererTargetTexture]

public
data RendererInfo = mkRendererInfo String (List RendererFlag) (List Bits32) Int Int

public
GetNumRenderDrivers : IO Int
GetNumRenderDrivers = mkForeign (FFun "SDL_GetNumRenderDrivers" [] FInt)

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

getTextureFormats : IO (List Bits32)
getTextureFormats = do
    hasNext <- mkForeign (FFun "idris_rendererInfo_hasTextureFormat" [] FInt)
    if (hasNext > 0)
      then do
        bits <- mkForeign (FFun "idris_rendererInfo_getTextureFormat" [] FBits32)
        rest <- getTextureFormats
        return (bits :: rest)
      else do
        return []

getRendererInfo_info : IO RendererInfo
getRendererInfo_info = do
    name <- mkForeign (FFun "idris_rendererInfo_name" [] FString)
    flags <- bitMaskToFlags `map` (mkForeign (FFun "idris_rendererInfo_flags" [] FBits32))
    formats <- getTextureFormats
    width <- mkForeign (FFun "idris_rendererInfo_max_texture_width" [] FInt)
    height <- mkForeign (FFun "idris_rendererInfo_max_texture_height" [] FInt)
    return (mkRendererInfo name flags formats width height)

public
GetRenderDriverInfo : Renderer -> IO (Either String RendererInfo)
GetRenderDriverInfo (mkRenderer ren) = do
    trySDLRes
        (mkForeign (FFun "idris_SDL_getRendererInfo" [FPtr] FInt) ren)
        getRendererInfo_info

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

getPixels : IO Pixels
getPixels =
    [| mkPixels (mkForeign (FFun "idris_getPixels" [] FPtr)) |]

getPitch : IO Int
getPitch =
    mkForeign (FFun "idris_getPitch" [] FInt)

public
LockTexture : Texture -> Rect -> IO (Either String (Pixels, Int))
LockTexture (mkTexture txt) (mkRect x y w h) =
    trySDLRes
        (mkForeign (FFun "idris_SDL_lockTexture" [FPtr, FInt, FInt, FInt, FInt] FInt) txt x y w h)
        [| (/*/) getPixels getPitch |]


public
UnlockTexture : Texture -> IO ()
UnlockTexture (mkTexture txt) = mkForeign (FFun "SDL_UnlockTexture" [FPtr] FUnit) txt

public
RenderTargetSupported : Renderer -> IO Bool
RenderTargetSupported (mkRenderer ren) =
    [| fromSDLBool (mkForeign (FFun "SDL_RenderTargetSupported" [FPtr] FInt) ren) |]

public
SetRenderTarget : Renderer -> Texture -> IO (Maybe String)
SetRenderTarget (mkRenderer ren) (mkTexture txt) =
    trySDL (mkForeign (FFun "SDL_SetRenderTarget" [FPtr, FPtr] FInt) ren txt)

public
GetRenderTarget : Renderer -> IO (Either String Texture)
GetRenderTarget (mkRenderer ren) =
    trySDLRes
        (mkForeign (FFun "idris_SDL_getRenderTarget" [FPtr] FInt) ren)
        [| mkTexture (mkForeign (FFun "idris_sharedTexture" [] FPtr)) |]

public
RenderLogicalSize : Renderer -> Int -> Int -> IO (Maybe String)
RenderLogicalSize (mkRenderer ren) w h =
    trySDL (mkForeign (FFun "SDL_RenderLogicalSize" [FPtr, FInt, FInt] FInt) ren w h)

--fixme, cannot fail
public
RenderGetLogicalSize : Renderer -> IO (Either String (Int, Int))
RenderGetLogicalSize (mkRenderer ren) =
    trySDLRes
        ((mkForeign (FFun "idris_SDL_renderGetLogicalSize" [FPtr] FUnit) ren) $> return 1)
        [| (/*/) getWidth getHeight |]

public
RenderSetViewport : Renderer -> Rect -> IO (Maybe String)
RenderSetViewport (mkRenderer ren) (mkRect x y w h) =
    trySDL (mkForeign (FFun "idris_SDL_renderSetViewport" [FPtr, FInt, FInt, FInt, FInt] FInt) ren x y w h)

getX : IO Int
getX = mkForeign (FFun "idris_render_sharedX_int" [] FInt)

getY : IO Int
getY = mkForeign (FFun "idris_render_sharedY_int" [] FInt)

getRect : IO Rect
getRect = [| mkRect getX
                    getY
                    getWidth
                    getHeight |]

--fixme, cannot fail
public
RenderGetViewport : Renderer -> IO (Either String Rect)
RenderGetViewport (mkRenderer ren) =
    trySDLRes
        ((mkForeign (FFun "idris_SDL_renderGetViewport" [FPtr] FUnit) ren) $> return 1)
        getRect

public
--int SDLCALL SDL_RenderSetClipRect(SDL_Renderer * renderer, const SDL_Rect * rect);
RenderSetClipRect : Renderer -> Rect -> IO (Maybe String)
RenderSetClipRect (mkRenderer ren) (mkRect x y w h) =
    trySDL (mkForeign (FFun "idris_SDL_renderSetClipRect" [FPtr, FInt, FInt, FInt, FInt] FInt) ren x y w h)

--fixme, cannot fail
public
RenderGetClipRect: Renderer -> IO (Either String Rect)
RenderGetClipRect (mkRenderer ren) =
    trySDLRes
        ((mkForeign (FFun "SDL_RenderGetClipRect" [FPtr] FUnit) ren) $> return 1)
        getRect

public
RenderSetScale : Renderer -> Int -> Int -> IO (Maybe String)
RenderSetScale (mkRenderer ren) scaleX scaleY =
    trySDL (mkForeign (FFun "SDL_RenderSetScale" [FPtr, FInt, FInt] FInt) ren scaleY scaleY)

public
RenderGetScale : Renderer -> IO (Either String (Int, Int))
RenderGetScale (mkRenderer ren) =
    trySDLRes
        ((mkForeign (FFun "idris_SDL_renderGetScale" [FPtr] FUnit) ren) $> return 1)
        [| (/*/) getX getY |]

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
