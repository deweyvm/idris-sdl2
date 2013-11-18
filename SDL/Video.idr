module SDL.Video

import SDL.Common
import SDL.Rect

%include C "SDL2/SDL_video.h"
%include C "SDL/idris_SDL_video.h"
%link C "idris_SDL_video.o"

public
GetNumVideoDrivers : IO Int
GetNumVideoDrivers = mkForeign (FFun "SDL_GetNumVideoDrivers" [] FInt) 

public 
GetVideoDriver : Int -> IO String
GetVideoDriver index = mkForeign (FFun "SDL_GetVideoDriver" [FInt] FString) index

public
VideoInit : String -> IO Int
VideoInit driver_name = mkForeign (FFun "SDL_VideoInit" [FString] FInt) driver_name

public
VideoQuit : IO ()
VideoQuit = mkForeign (FFun "SDL_VideoQuit" [] FUnit)

public
GetCurrentVideoDriver : IO String
GetCurrentVideoDriver = mkForeign (FFun "SDL_GetCurrentVideoDriver" [] FString)

public
GetNumVideoDisplays : IO Int
GetNumVideoDisplays = mkForeign (FFun "SDL_GetNumVideoDisplays" [] FInt)

public 
GetDisplayName : Int -> IO String
GetDisplayName displayIndex = mkForeign (FFun "SDL_GetDisplayName" [FInt] FString) displayIndex

getDisplayX : Int -> IO Int
getDisplayX index = mkForeign (FFun "idris_SDL_getDisplayX" [FInt] FInt) index

getDisplayY : Int -> IO Int
getDisplayY index = mkForeign (FFun "idris_SDL_getDisplayY" [FInt] FInt) index

getDisplayWidth : Int -> IO Int
getDisplayWidth index = mkForeign (FFun "idris_SDL_getDisplayWidth" [FInt] FInt) index

getDisplayHeight : Int -> IO Int
getDisplayHeight index =  mkForeign (FFun "idris_SDL_getDisplayHeight" [FInt] FInt) index

public
GetDisplayBounds : Int -> IO Rect
GetDisplayBounds index = do
    x <- getDisplayX index
    y <- getDisplayY index
    w <- getDisplayWidth index
    h <- getDisplayHeight index
    return $ mkRect x y w h
