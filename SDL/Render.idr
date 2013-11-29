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
QueryTexture (mkTexture txt) =
    trySDLRes
        (mkForeign (FFun "idris_SDL_queryTexture" [FPtr] FInt) txt)
        [| mkTextureInfo getFormat
                         (read `map` getTextureAccess)
                         getWidth
                         getHeight |]

-- | alpha is ignored
public
SetTextureColorMod : Texture -> Color -> IO (Maybe String)
SetTextureColorMod (mkTexture txt) (mkColor r g b _) =
    trySDL (mkForeign (FFun "SetTextureColorMod" [FPtr, FBits8, FBits8, FBits8] FInt) txt r g b)

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
GetTextureColorMod (mkTexture txt) =
    trySDLRes
        (mkForeign (FFun "idris_SDL_getTextureColorMod" [FPtr] FInt) txt)
        [| mkColor getRed
                   getGreen
                   getBlue
                   (return 0xFF) |]

public
SetTextureAlphaMod : Texture -> Bits8 -> IO (Maybe String)
SetTextureAlphaMod (mkTexture txt) a =
    trySDL (mkForeign (FFun "SDL_SetTextureAlphaMod" [FPtr, FBits8] FInt) txt a)

getAlpha : IO Bits8
getAlpha = mkForeign (FFun "idris_getAlpha_uint8" [] FBits8)

public
GetTextureAlphaMod : Texture -> IO (Either String Bits8)
GetTextureAlphaMod (mkTexture txt) =
    trySDLRes
        (mkForeign (FFun "idris_SDL_getTextureAlphaMod" [FPtr] FInt) txt)
        getAlpha

public
SetTextureBlendMode : Texture -> BlendMode -> IO (Maybe String)
SetTextureBlendMode (mkTexture txt) mode =
    trySDL (mkForeign (FFun "SDL_SetTextureBlendMode" [FPtr, FBits32] FInt) txt (toFlag mode))

--fixme, display flag and type of flag
--probably also a bad API, just return a maybe and let the user handle it?
extractFlag : (Bits32 -> Maybe a) -> Either String Bits32 -> Either String a
extractFlag f e = e >>= ((maybeToEither ("Unable to read flag")) . f)

public
GetTextureBlendMode : Texture -> IO (Either String BlendMode)
GetTextureBlendMode (mkTexture txt) =
    (extractFlag read) `map` (trySDLRes
        (mkForeign (FFun "idris_SDL_getTextureBlendMode" [FPtr] FInt) txt)
        (mkForeign (FFun "idris_getBlendMode_mode" [] FBits32)))

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
SetRenderDrawColor : Renderer -> Color -> IO (Maybe String)
SetRenderDrawColor (mkRenderer ren) (mkColor r g b a) =
   trySDL (mkForeign (FFun "SDL_SetRenderDrawColor" [FPtr, FBits8, FBits8, FBits8, FBits8] FInt) ren r g b a)

public
GetRenderDrawColor : Renderer -> IO (Either String Color)
GetRenderDrawColor (mkRenderer ren) =
    trySDLRes
        (mkForeign (FFun "idris_SDL_getRenderDrawColor" [FPtr] FInt) ren)
        [| mkColor getRed
                   getGreen
                   getBlue
                   getAlpha |]

public
SetRenderDrawBlendMode : Renderer -> BlendMode -> IO (Maybe String)
SetRenderDrawBlendMode (mkRenderer ren) mode =
    trySDL (mkForeign (FFun "SDL_SetRenderDrawBlendMode" [FPtr, FBits32] FInt) ren (toFlag mode))

public
GetRenderDrawBlendMode : Renderer -> IO (Either String BlendMode)
GetRenderDrawBlendMode (mkRenderer ren) =
    (extractFlag read) `map` trySDLRes
        (mkForeign (FFun "idris_SDL_getRenderDrawBlendMode" [FPtr] FInt) ren)
        (mkForeign (FFun "idris_getBlendMode_mode" [] FBits32))

--extern DECLSPEC int SDLCALL SDL_RenderClear(SDL_Renderer * renderer);
public
RenderClear : Renderer -> IO (Maybe String)
RenderClear (mkRenderer ren) =
    trySDL (mkForeign (FFun "SDL_RenderClear" [FPtr] FInt) ren)

public
RenderDrawPoint : Renderer -> Point -> IO (Maybe String)
RenderDrawPoint (mkRenderer ren) (mkPoint x y) =
    trySDL (mkForeign (FFun "SDL_RenderDrawPoint" [FPtr, FInt, FInt] FInt) ren x y)

--fixme, use the array version and return an error properly
public total
RenderDrawPoints : Renderer -> List Point -> IO (Maybe String)
RenderDrawPoints ren (x::xs) = (RenderDrawPoint ren x) <$ RenderDrawPoints ren xs
RenderDrawPoints ren [] = return Nothing

public
RenderDrawLine : Renderer -> Point -> Point -> IO (Maybe String)
RenderDrawLine (mkRenderer ren) (mkPoint x1 y1) (mkPoint x2 y2) =
    trySDL (mkForeign (FFun "SDL_RenderDrawLine" [FPtr, FInt, FInt, FInt, FInt] FInt) ren x1 y1 x2 y2)

public total
RenderDrawLines : Renderer -> List Point -> IO (Maybe String)
RenderDrawLines ren (x::y::xs) = (RenderDrawLine ren x y) <$ (RenderDrawLines ren (y :: xs))
RenderDrawLines ren (x::[]) = return Nothing
RenderDrawLines ren [] = return Nothing

public
RenderDrawRect : Renderer -> Rect -> IO (Maybe String)
RenderDrawRect (mkRenderer ren) (mkRect x y w h) =
    trySDL (mkForeign (FFun "idris_SDL_renderDrawRect" [FPtr, FInt, FInt, FInt, FInt] FInt) ren x y w h)

public total
RenderDrawRects : Renderer -> List Rect -> IO (Maybe String)
RenderDrawRects ren [] = return Nothing
RenderDrawRects ren (x::xs) = RenderDrawRect ren x <$ RenderDrawRects ren xs


public
RenderFillRect : Renderer -> Rect -> IO (Maybe String)
RenderFillRect (mkRenderer ren) (mkRect x y w h) =
    trySDL (mkForeign (FFun "idris_SDL_renderFillRect" [FPtr, FInt, FInt, FInt, FInt] FInt) ren x y w h)

public total
RenderFillRects : Renderer -> List Rect -> IO (Maybe String)
RenderFillRects ren [] = return Nothing
RenderFillRects ren (x::xs) = RenderFillRect ren x <$ RenderFillRects ren xs

public
RenderCopy : Renderer -> Texture -> Rect -> Rect -> IO (Maybe String)
RenderCopy (mkRenderer ren) (mkTexture txt) (mkRect sx sy sw sh) (mkRect dx dy dw dh) =
    trySDL (mkForeign (FFun "idris_SDL_renderCopy" [FPtr, FPtr, FInt, FInt, FInt, FInt, FInt, FInt, FInt, FInt] FInt) ren txt sx sy sw sh dx dy dw dh)

public
data RendererFlip = FlipNone
                  | FlipHorizontal
                  | FlipVertical

instance Flag Bits32 RendererFlip where
    toFlag FlipNone       = 0x00000000
    toFlag FlipHorizontal = 0x00000001
    toFlag FlipVertical   = 0x00000002

public
RenderCopyEx : Renderer -> Texture -> Rect -> Rect -> Float -> Point -> RendererFlip -> IO (Maybe String)
RenderCopyEx (mkRenderer ren) (mkTexture txt) (mkRect sx sy sw sh) (mkRect dx dy dw dh) angle (mkPoint cx cy) flip =
    trySDL (mkForeign (FFun "idris_SDL_renderCopyEX" [FPtr, FPtr,
                                                      FInt, FInt, FInt, FInt,
                                                      FInt, FInt, FInt, FInt,
                                                      FFloat, FInt, FInt, FBits32]
           FInt) ren txt sx sy sw sh dx dy dw dh angle cx cy (toFlag flip))

public
RenderReadPixels : Renderer -> Rect -> {-PixelFormat-}Bits32 -> Int -> IO (Either String Pixels)
RenderReadPixels (mkRenderer ren) (mkRect x y w h) format pitch =
    trySDLRes
        (mkForeign (FFun "idris_SDL_renderReadPixels" [FPtr, FInt, FInt, FInt, FInt, FBits32, FInt] FInt) ren x y w h format pitch)
        [| mkPixels (mkForeign (FFun "idris_getSharedPixels" [] FPtr)) |]

public
RenderPresent : Renderer -> IO ()
RenderPresent (mkRenderer ren) =
    mkForeign (FFun "SDL_RenderPresent" [FPtr] FUnit) ren

public
DestroyTexture : Texture -> IO ()
DestroyTexture (mkTexture txt) =
    mkForeign (FFun "SDL_DestroyTexture" [FPtr] FUnit) txt

public
DestroyRenderer : Renderer -> IO ()
DestroyRenderer (mkRenderer ren) =
    mkForeign (FFun "SDL_DestroyRenderer" [FPtr] FUnit) ren
