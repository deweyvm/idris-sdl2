module Graphics.SDL.Pixels

import Graphics.SDL.Common

%include C "SDL2/SDL_pixels.h"
%include C "csrc/idris_SDL_pixels.h"
%link C "idris_SDL_pixels.o"

public
data Pixels = MkPixels Ptr

public
data Color = MkColor Bits8 Bits8 Bits8 Bits8

public
red : Color
red = MkColor 0xFF 0xFF 0xFF 0xFF

public
data Palette = MkPalette Ptr

public
data PixelFormat = MkPixelFormat Ptr

public
data PixelFormatBits = Unknown
                     | Index1LSB
                     | Index1MSB
                     | Index4LSB
                     | Index4MSB
                     | Index8
                     | RGB332
                     | RGB444
                     | RGB555
                     | BGR555
                     | ARGB4444
                     | RGBA4444
                     | ABGR4444
                     | BGRA4444
                     | ARGB1555
                     | RGBA5551
                     | ABGR1555
                     | BGRA5551
                     | RGB565
                     | BGR565
                     | RGB24
                     | BGR24
                     | RGB888
                     | RGBX8888
                     | BGR888
                     | BGRX8888
                     | ARGB8888
                     | RGBA8888
                     | ABGR8888
                     | BGRA8888
                     | ARGB2101010
                     | YV12
                     | IYUV
                     | YUY2
                     | UYVY
                     | YYVU

instance Flag Bits32 PixelFormatBits where
    toFlag Unknown     = 0x00000000
    toFlag Index1LSB   = 0x11100100
    toFlag Index1MSB   = 0x11200100
    toFlag Index4LSB   = 0x12100400
    toFlag Index4MSB   = 0x12200400
    toFlag Index8      = 0x13000801
    toFlag RGB332      = 0x14110801
    toFlag RGB444      = 0x15120C02
    toFlag RGB555      = 0x15130F02
    toFlag BGR555      = 0x15530F02
    toFlag ARGB4444    = 0x15321002
    toFlag RGBA4444    = 0x15421002
    toFlag ABGR4444    = 0x15721002
    toFlag BGRA4444    = 0x15821002
    toFlag ARGB1555    = 0x15331002
    toFlag RGBA5551    = 0x15441002
    toFlag ABGR1555    = 0x15731002
    toFlag BGRA5551    = 0x15841002
    toFlag RGB565      = 0x15151002
    toFlag BGR565      = 0x15551002
    toFlag RGB24       = 0x17101803
    toFlag BGR24       = 0x17401803
    toFlag RGB888      = 0x16161804
    toFlag RGBX8888    = 0x16261804
    toFlag BGR888      = 0x16561804
    toFlag BGRX8888    = 0x16661804
    toFlag ARGB8888    = 0x16362004
    toFlag RGBA8888    = 0x16462004
    toFlag ABGR8888    = 0x16762004
    toFlag BGRA8888    = 0x16862004
    toFlag ARGB2101010 = 0x16372004
    toFlag YV12        = 0x32315659
    toFlag IYUV        = 0x56555949
    toFlag YUY2        = 0x32595559
    toFlag UYVY        = 0x59565955
    toFlag YYVU        = 0x55595659

instance Enumerable PixelFormatBits where
    enumerate = [Index1LSB, Index1MSB, Index4LSB, Index4MSB, Index8, RGB332, RGB444, RGB555, BGR555, ARGB4444, RGBA4444, ABGR4444, BGRA4444, ARGB1555, RGBA5551, ABGR1555, BGRA5551, RGB565, BGR565, RGB24, BGR24, RGB888, RGBX8888, BGR888, BGRX8888, ARGB8888, RGBA8888, ABGR8888, BGRA8888, ARGB2101010, YV12, IYUV, YUY2, UYVY, YYVU]

public
getPixelFormatName : PixelFormatBits -> IO String
getPixelFormatName bits = mkForeign (FFun "SDL_GetPixelFormatName" [FBits32] FString) (toFlag bits)

getBpp : IO Int
getBpp = mkForeign (FFun "idris_SDL_pixelFormatEnumToMasks_bpp" [] FInt)

getRMask : IO Bits32
getRMask = mkForeign (FFun "idris_SDL_pixelFormatEnumToMasks_Rmask" [] FBits32)

getGMask : IO Bits32
getGMask = mkForeign (FFun "idris_SDL_pixelFormatEnumToMasks_Gmask" [] FBits32)

getBMask : IO Bits32
getBMask = mkForeign (FFun "idris_SDL_pixelFormatEnumToMasks_Bmask" [] FBits32)

getAMask : IO Bits32
getAMask = mkForeign (FFun "idris_SDL_pixelFormatEnumToMasks_Amask" [] FBits32)

public
pixelFormatEnumToMasks : PixelFormatBits -> IO (Int, Bits32, Bits32, Bits32, Bits32)
pixelFormatEnumToMasks fmt = do
    mkForeign (FFun "idris_SDL_pixelFormatEnumToMasks" [FBits32] FUnit) (toFlag fmt)
    bpp <- getBpp
    rmask <- getRMask
    gmask <- getGMask
    bmask <- getBMask
    amask <- getAMask
    return (bpp, rmask, gmask, bmask, amask)

public
masksToPixelFormatEnum : Int -> Bits32 -> Bits32 -> Bits32 -> Bits32 -> IO PixelFormatBits
masksToPixelFormatEnum bpp rmask gmask bmask amask =
    [| (readOrElse Unknown) (mkForeign (FFun "SDL_MasksToPixelFormatEnum" [FInt, FBits32, FBits32, FBits32, FBits32] FBits32) bpp rmask gmask bmask amask) |]

public
allocFormat : PixelFormatBits -> IO PixelFormat
allocFormat bits =
    [| MkPixelFormat (mkForeign (FFun "SDL_AllocFormat" [FBits32] FPtr) (toFlag bits)) |]

public
freeFormat : PixelFormat -> IO ()
freeFormat (MkPixelFormat fmt) = mkForeign (FFun "SDL_FreeFormat" [FPtr] FUnit) fmt

--FIXME is it okay to free the array immediately after passing it to SDL an SDL function?
--for now, malloc failure will just return an empty palette
public
makePalette : List Color -> IO Palette
makePalette colors = do
    success <- [| fromSDLBool (mkForeign (FFun "idris_makeColorArray" [FInt] FInt) (fromNat $ length colors)) |]
    --fixme, ignored malloc failure
    sequence_ $ map pushColor colors --okay because of strict eval
    ptr <- mkForeign (FFun "idris_colorArrayGet" [] FPtr)
    return $ MkPalette ptr
  where
    pushColor : Color -> IO ()
    pushColor (MkColor r g b a) = mkForeign (FFun "idris_colorArrayPush" [FBits8, FBits8, FBits8, FBits8] FUnit) r g b a

public
setPixelFormatPalette : Palette -> PixelFormat -> IO (Maybe String)
setPixelFormatPalette (MkPalette pal) (MkPixelFormat fmt) =
    doSDL (mkForeign (FFun "SDL_SetPixelFormatPalette" [FPtr, FPtr] FInt) pal fmt)

--may be dangerous
public
destroyPalette : Palette -> IO ()
destroyPalette (MkPalette ptr) = mkForeign (FFun "idris_colorArrayFree" [FPtr] FUnit) ptr


--alpha in color ignored
public
mapRGB : PixelFormat -> Color -> IO Bits32
mapRGB (MkPixelFormat fmt) (MkColor r g b _) =
    mkForeign (FFun "idris_SDL_mapRGB" [FPtr, FBits8, FBits8, FBits8] FBits32) fmt r g b

public
mapRGBA : PixelFormat -> Color -> IO Bits32
mapRGBA (MkPixelFormat fmt) (MkColor r g b a) =
    mkForeign (FFun "idris_SDL_mapRGBA" [FPtr, FBits8, FBits8, FBits8, FBits8] FBits32) fmt r g b a


getR : IO Bits8
getR = mkForeign (FFun "idris_SDL_getRGB_r" [] FBits8)

getG : IO Bits8
getG = mkForeign (FFun "idris_SDL_getRGB_g" [] FBits8)

getB : IO Bits8
getB = mkForeign (FFun "idris_SDL_getRGB_b" [] FBits8)

getA : IO Bits8
getA = mkForeign (FFun "idris_SDL_getRGB_a" [] FBits8)

--alpha value returned is always 255
--might be pure
public
getRGB : Bits32{-raw pixel-} -> PixelFormat -> IO Color
getRGB pixel (MkPixelFormat fmt) = do
    mkForeign (FFun "idris_SDL_getRGB" [FBits32, FPtr] FUnit) pixel fmt
    color <- [| MkColor getR getG getB (return 255)|]
    return color

--might be pure
public
getRGBA : Bits32{-raw pixel-} -> PixelFormat -> IO Color
getRGBA pixel (MkPixelFormat fmt) = do
    mkForeign (FFun "idris_SDL_getRGBA" [FBits32, FPtr] FUnit) pixel fmt
    color <- [| MkColor getR getG getB getA |]
    return color

--might be pure
public
calculateGammaRamp : Float -> IO Bits16
calculateGammaRamp gamma = mkForeign (FFun "idris_SDL_calculateGammaRamp" [FFloat] FBits16) gamma
