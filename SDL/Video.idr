module SDL.Video

import SDL.Common
import SDL.SDL
import SDL.Rect

%include C "SDL2/SDL_video.h"
%include C "SDL/idris_SDL_video.h"
%link C "idris_SDL_video.o"

public
data Window = mkWindow Ptr

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
getDisplayBounds_x = mkForeign (FFun "idris_SDL_getDisplayBounds_x" [] FInt)

getDisplayBounds_y : IO Int
getDisplayBounds_y = mkForeign (FFun "idris_SDL_getDisplayBounds_y" [] FInt)

getDisplayBounds_w : IO Int
getDisplayBounds_w = mkForeign (FFun "idris_SDL_getDisplayBounds_w" [] FInt)

getDisplayBounds_h : IO Int
getDisplayBounds_h =  mkForeign (FFun "idris_SDL_getDisplayBounds_h" [] FInt)

public
GetDisplayBounds : Int -> IO (Either String Rect)
GetDisplayBounds index = do
    isValid <- checkGetDisplayBounds index
    if (isValid /= 0) 
      then do
        err <- GetError
        return $ Left err
      else do
        x <- getDisplayBounds_x
        y <- getDisplayBounds_y
        w <- getDisplayBounds_w
        h <- getDisplayBounds_h
        return $ Right $ mkRect x y w h 
          
        
public 
GetNumDisplayModes : Int -> IO Int
GetNumDisplayModes index = mkForeign (FFun "SDL_GetNumDisplayModes" [FInt] FInt) index

public
data DisplayMode = mkDisplayMode Int Int Int Int Ptr

instance Show DisplayMode where
    show (mkDisplayMode format w h refresh_rate _) =
        "DisplayMode " ++ (show format) ++ " " ++ (show w) ++ " " ++ (show h) ++ " " ++ show (refresh_rate)

checkGetDisplayMode : Int -> Int -> IO Int
checkGetDisplayMode displayIndex modeIndex =
    mkForeign (FFun "idris_SDL_getDisplayMode" [FInt, FInt] FInt) displayIndex modeIndex

--fixme - lossy coersion from uint to int
getDisplayMode_format : IO Int
getDisplayMode_format = mkForeign (FFun "idris_SDL_getDisplayMode_format" [] FInt)

getDisplayMode_w : IO Int
getDisplayMode_w = mkForeign (FFun "idris_SDL_getDisplayMode_w" [] FInt)

getDisplayMode_h : IO Int
getDisplayMode_h = mkForeign (FFun "idris_SDL_getDisplayMode_h" [] FInt)

getDisplayMode_refresh_rate : IO Int
getDisplayMode_refresh_rate =
    mkForeign (FFun "idris_SDL_getDisplayMode_refresh_rate" [] FInt)

getDisplayMode_driverdata : IO Ptr
getDisplayMode_driverdata =
    mkForeign (FFun "idris_SDL_getDisplayMode_driverdata" [] FPtr)

public
GetDisplayMode : Int -> Int -> IO (Either String DisplayMode)
GetDisplayMode displayIndex modeIndex = do
    isValid <- checkGetDisplayMode displayIndex modeIndex
    if (isValid /= 0)
      then do
        err <- GetError
        return $ Left err
      else do
        mode <- return mkDisplayMode <$> getDisplayMode_format
                                     <$> getDisplayMode_w
                                     <$> getDisplayMode_h
                                     <$> getDisplayMode_refresh_rate
                                     <$> getDisplayMode_driverdata
        return $ Right mode
        
checkGetDesktopDisplayMode : Int -> IO Int
checkGetDesktopDisplayMode displayIndex = 
      mkForeign (FFun "idris_getDesktopDisplayMode" [FInt] FInt) displayIndex

--fixme - lossy coersion from unsigned int
getDesktopDisplayMode_format : IO Int
getDesktopDisplayMode_format =
    mkForeign (FFun "idris_getDesktopDisplayMode_format" [] FInt)

getDesktopDisplayMode_w : IO Int
getDesktopDisplayMode_w =
      mkForeign (FFun "idris_getDesktopDisplayMode_w" [] FInt)

getDesktopDisplayMode_h : IO Int
getDesktopDisplayMode_h =
    mkForeign (FFun "idris_getDesktopDisplayMode_h" [] FInt)

getDesktopDisplayMode_refresh_rate : IO Int
getDesktopDisplayMode_refresh_rate =
      mkForeign (FFun "idris_getDesktopDisplayMode_refresh_rate" [] FInt)

getDesktopDisplayMode_driverdata : IO Ptr
getDesktopDisplayMode_driverdata =
    mkForeign (FFun "idris_getDesktopDisplayMode_driverdata" [] FPtr)

GetDesktopDisplayMode : Int -> IO (Either String DisplayMode)
GetDesktopDisplayMode displayIndex = do
    isValid <- checkGetDesktopDisplayMode displayIndex 
    if (isValid /= 0)
      then do
        err <- GetError
        return $ Left err
      else do
        mode <- return mkDisplayMode <$> getDesktopDisplayMode_format
                                     <$> getDesktopDisplayMode_w
                                     <$> getDesktopDisplayMode_h
                                     <$> getDesktopDisplayMode_refresh_rate
                                     <$> getDesktopDisplayMode_driverdata
        return $ Right mode