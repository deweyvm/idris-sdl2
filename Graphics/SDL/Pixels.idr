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

--may be dangerous
public
destroyPalette : Palette -> IO ()
destroyPalette (MkPalette ptr) = mkForeign (FFun "idris_colorArrayFree" [FPtr] FUnit) ptr


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

--alpha in color ignored
public
mapRGB : PixelFormat -> Color -> IO Bits32
mapRGB (MkPixelFormat fmt) (MkColor r g b _) =
    mkForeign (FFun "idris_SDL_mapRGB" [FPtr, FBits8, FBits8, FBits8] FBits32) fmt r g b

public
mapRGBA : PixelFormat -> Color -> IO Bits32
mapRGBA (MkPixelFormat fmt) (MkColor r g b a) =
    mkForeign (FFun "idris_SDL_mapRGBA" [FPtr, FBits8, FBits8, FBits8, FBits8] FBits32) fmt r g b a
