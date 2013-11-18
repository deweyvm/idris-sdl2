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

checkGetDisplayBounds : Int -> IO Int
checkGetDisplayBounds index = mkForeign (FFun "idris_SDL_getDisplayBounds" [FInt] FInt) index

getDisplayBounds_x : IO Int
getDisplayBounds_x = mkForeign (FFun "idris_SDL_getDisplayBounds_x" [] FIn	t) index

getDisplayBounds_y : IO Int
getDisplayBounds_y = mkForeign (FFun "idris_SDL_getDisplayBounds_y" [] FInt) index

getDisplayBounds_w : IO Int
getDisplayBounds_w index = mkForeign (FFun "idris_SDL_getDisplayBounds_w" [] FInt) index

getDisplayBounds_h : IO Int
getDisplayBounds_h =  mkForeign (FFun "idris_SDL_getDisplayBounds_h" [] FInt) index

GetDisplayBounds : Int -> IO (Maybe Int)
GetDisplayBounds index = do
   isValid <- get index
   if (not isValid) 
     then 
       return Nothing
     else 
      do
       x <- getDisplayBounds_x
       y <- getDisplayBounds_y
       w <- getDisplayBounds_w
       h <- getDisplayBounds_h
       return $ Just $ mkRect x y w h 
          
        

{-public
GetDisplayBounds : Int -> IO Rect
GetDisplayBounds index = do
    x <- getDisplayBounds_x index
    y <- getDisplayBounds_y index
    w <- getDisplayBounds_w index
    h <- getDisplayBounds_h index
    return $ mkRect x y w h

public 
GetNumDisplayModes : Int -> IO Int
GetNumDisplayModes index = mkForeign (FFun "SDL_GetNumDisplayModes" [FInt] FInt) index

data DisplayMode = mkDisplayMode Nat Int Int Int Ptr

public 
GetDisplayMode : Int -> Int -> DisplayMode
GetDisplayMode-}