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
data Palette = MkPalette (Maybe Ptr)

public
data PixelFormat = PixelFormatUnknown
                 | PixelFormatIndex1LSB
                 | PixelFormatIndex1MSB
                 | PixelFormatIndex4LSB
                 | PixelFormatIndex4MSB
                 | PixelFormatIndex8
                 | PixelFormatRGB332
                 | PixelFormatRGB444
                 | PixelFormatRGB555
                 | PixelFormatBGR555
                 | PixelFormatARGB4444
                 | PixelFormatRGBA4444
                 | PixelFormatABGR4444
                 | PixelFormatBGRA4444
                 | PixelFormatARGB1555
                 | PixelFormatRGBA5551
                 | PixelFormatABGR1555
                 | PixelFormatBGRA5551
                 | PixelFormatRGB565
                 | PixelFormatBGR565
                 | PixelFormatRGB24
                 | PixelFormatBGR24
                 | PixelFormatRGB888
                 | PixelFormatRGBX8888
                 | PixelFormatBGR888
                 | PixelFormatBGRX8888
                 | PixelFormatARGB8888
                 | PixelFormatRGBA8888
                 | PixelFormatABGR8888
                 | PixelFormatBGRA8888
                 | PixelFormatARGB2101010
                 | PixelFormatYV12
                 | PixelFormatIYUV
                 | PixelFormatYUY2
                 | PixelFormatUYVY
                 | PixelFormatYYVU

instance Flag Bits32 PixelFormat where
    toFlag PixelFormatUnknown     = 0x00000000
    toFlag PixelFormatIndex1LSB   = 0x11100100
    toFlag PixelFormatIndex1MSB   = 0x11200100
    toFlag PixelFormatIndex4LSB   = 0x12100400
    toFlag PixelFormatIndex4MSB   = 0x12200400
    toFlag PixelFormatIndex8      = 0x13000801
    toFlag PixelFormatRGB332      = 0x14110801
    toFlag PixelFormatRGB444      = 0x15120C02
    toFlag PixelFormatRGB555      = 0x15130F02
    toFlag PixelFormatBGR555      = 0x15530F02
    toFlag PixelFormatARGB4444    = 0x15321002
    toFlag PixelFormatRGBA4444    = 0x15421002
    toFlag PixelFormatABGR4444    = 0x15721002
    toFlag PixelFormatBGRA4444    = 0x15821002
    toFlag PixelFormatARGB1555    = 0x15331002
    toFlag PixelFormatRGBA5551    = 0x15441002
    toFlag PixelFormatABGR1555    = 0x15731002
    toFlag PixelFormatBGRA5551    = 0x15841002
    toFlag PixelFormatRGB565      = 0x15151002
    toFlag PixelFormatBGR565      = 0x15551002
    toFlag PixelFormatRGB24       = 0x17101803
    toFlag PixelFormatBGR24       = 0x17401803
    toFlag PixelFormatRGB888      = 0x16161804
    toFlag PixelFormatRGBX8888    = 0x16261804
    toFlag PixelFormatBGR888      = 0x16561804
    toFlag PixelFormatBGRX8888    = 0x16661804
    toFlag PixelFormatARGB8888    = 0x16362004
    toFlag PixelFormatRGBA8888    = 0x16462004
    toFlag PixelFormatABGR8888    = 0x16762004
    toFlag PixelFormatBGRA8888    = 0x16862004
    toFlag PixelFormatARGB2101010 = 0x16372004
    toFlag PixelFormatYV12        = 0x32315659
    toFlag PixelFormatIYUV        = 0x56555949
    toFlag PixelFormatYUY2        = 0x32595559
    toFlag PixelFormatUYVY        = 0x59565955
    toFlag PixelFormatYYVU        = 0x55595659

--may be dangerous
public
destroyPalette : Palette -> IO ()
destroyPalette (MkPalette (Just ptr)) = mkForeign (FFun "idris_colorArrayFree" [FPtr] FUnit) ptr
destroyPalette (MkPalette Nothing) = return ()

--FIXME is it okay to free the array immediately after passing it to SDL an SDL function?
--for now, malloc failure will just return an empty palette
public
makePalette : List Color -> IO Palette
makePalette colors = do
    success <- [| fromSDLBool (mkForeign (FFun "idris_makeColorArray" [FInt] FInt) (fromNat $ length colors)) |]
    if (not success)
      then return (MkPalette Nothing)
      else do
        sequence_ $ map pushColor colors --okay because of strict eval
        ptr <- mkForeign (FFun "idris_colorArrayGet" [] FPtr)
        return $ MkPalette $ Just ptr
  where
    pushColor : Color -> IO ()
    pushColor (MkColor r g b a) = mkForeign (FFun "idris_colorArrayPush" [FBits8, FBits8, FBits8, FBits8] FUnit) r g b a


