module Graphics.SDL.Video

import Graphics.SDL.Common
import Graphics.SDL.SDL
import Graphics.SDL.Rect
import Graphics.SDL.Surface
import Data.Bits

%include C "SDL2/SDL_video.h"
%include C "csrc/idris_SDL_video.h"
%link C "idris_SDL_video.o"

--a window must never be null. We must assure through our C wrapper that a null
-- pointer is never passed to mkWindow
--fixme: should be abstract
public
data Window = mkWindow Ptr

instance Show Window where
    show x = "Window"

public
getNumVideoDrivers : IO Int
getNumVideoDrivers = mkForeign (FFun "SDL_GetNumVideoDrivers" [] FInt)

public
getVideoDriver : Int -> IO String
getVideoDriver index = mkForeign (FFun "SDL_GetVideoDriver" [FInt] FString) index

public
videoInit : String -> IO Int
videoInit driver_name = mkForeign (FFun "SDL_VideoInit" [FString] FInt) driver_name

public
videoQuit : IO ()
videoQuit = mkForeign (FFun "SDL_VideoQuit" [] FUnit)

public
getCurrentVideoDriver : IO String
getCurrentVideoDriver = mkForeign (FFun "SDL_GetCurrentVideoDriver" [] FString)

public
getNumVideoDisplays : IO Int
getNumVideoDisplays = mkForeign (FFun "SDL_GetNumVideoDisplays" [] FInt)

public
getDisplayName : Int -> IO String
getDisplayName displayIndex = mkForeign (FFun "SDL_GetDisplayName" [FInt] FString) displayIndex

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
getDisplayBounds : Int -> IO (Either String Rect)
getDisplayBounds index = do
    doSDLIf
        (checkGetDisplayBounds index)
        [| mkRect getDisplayBounds_x
                  getDisplayBounds_y
                  getDisplayBounds_w
                  getDisplayBounds_h |]


public
getNumDisplayModes : Int -> IO Int
getNumDisplayModes index = mkForeign (FFun "SDL_GetNumDisplayModes" [FInt] FInt) index

public
data DisplayMode = mkDisplayMode Bits32 Int Int Int Ptr

instance Show DisplayMode where
    show (mkDisplayMode format w h refresh_rate _) =
        "DisplayMode " ++ (show format) ++ " " ++ (show w) ++ " " ++ (show h) ++ " " ++ show (refresh_rate)

sharedDisplayMode_format : IO Bits32
sharedDisplayMode_format =
    mkForeign (FFun "idris_sharedDisplayMode_format" [] FBits32)

sharedDisplayMode_w : IO Int
sharedDisplayMode_w =
    mkForeign (FFun "idris_sharedDisplayMode_w" [] FInt)

sharedDisplayMode_h : IO Int
sharedDisplayMode_h =
    mkForeign (FFun "idris_sharedDisplayMode_h" [] FInt)

sharedDisplayMode_refresh_rate : IO Int
sharedDisplayMode_refresh_rate =
    mkForeign (FFun "idris_sharedDisplayMode_refresh_rate" [] FInt)

sharedDisplayMode_driverdata : IO Ptr
sharedDisplayMode_driverdata =
    mkForeign (FFun "idris_sharedDisplayMode_driverdata" [] FPtr)

checkGetDisplayMode : Int -> Int -> IO Int
checkGetDisplayMode displayIndex modeIndex =
    mkForeign (FFun "idris_SDL_getDisplayMode" [FInt, FInt] FInt) displayIndex modeIndex

getSharedDisplayMode : IO DisplayMode
getSharedDisplayMode = do
    [| mkDisplayMode sharedDisplayMode_format
                     sharedDisplayMode_w
                     sharedDisplayMode_h
                     sharedDisplayMode_refresh_rate
                     sharedDisplayMode_driverdata |]

public
getDisplayMode : Int -> Int -> IO (Either String DisplayMode)
getDisplayMode displayIndex modeIndex = do
    doSDLIf
        (checkGetDisplayMode displayIndex modeIndex)
        (getSharedDisplayMode)

checkGetDesktopDisplayMode : Int -> IO Int
checkGetDesktopDisplayMode displayIndex =
    mkForeign (FFun "idris_SDL_getDesktopDisplayMode" [FInt] FInt) displayIndex

public
getDesktopDisplayMode : Int -> IO (Either String DisplayMode)
getDesktopDisplayMode displayIndex = do
    doSDLIf
        (checkGetDesktopDisplayMode displayIndex)
        (getSharedDisplayMode)

checkGetCurrentDisplayMode : Int -> IO Int
checkGetCurrentDisplayMode displayIndex =
    mkForeign (FFun "idris_SDL_getCurrentDisplayMode" [FInt] FInt) displayIndex

public
getCurrentDisplayMode : Int -> IO (Either String DisplayMode)
getCurrentDisplayMode displayIndex = do
    doSDLIf
        (checkGetCurrentDisplayMode displayIndex)
        (getSharedDisplayMode)

public
getClosestDisplayMode : Int -> DisplayMode -> IO (Either String DisplayMode)
getClosestDisplayMode displayIndex (mkDisplayMode format w h hz ddata) = do
    doSDLIf
        (mkForeign (FFun "idris_SDL_getClosestDisplayMode" [FInt, FBits32, FInt, FInt, FInt, FPtr] FInt) displayIndex format w h hz ddata)
        (getSharedDisplayMode)

public
getWindowDisplayIndex : Window -> IO (Maybe Int)
getWindowDisplayIndex (mkWindow ptr) = do
    index <- mkForeign (FFun "SDL_GetWindowDisplayIndex" [FPtr] FInt) ptr
    return $ case index of
      -1 => Nothing
      n  => Just n

public
setWindowDisplayMode : Window -> DisplayMode -> IO (Maybe String)
setWindowDisplayMode (mkWindow ptr) (mkDisplayMode format w h hz ddata) = do
    doSDL (mkForeign (FFun "idris_SDL_setWindowDisplayMode" [FPtr, FBits32, FInt, FInt, FInt, FPtr] FInt) ptr format w h hz ddata)

public
getWindowDisplayMode : Window -> IO (Either String DisplayMode)
getWindowDisplayMode (mkWindow ptr) = do
    doSDLIf
        (mkForeign (FFun "idris_SDL_getWindowDisplayMode" [FPtr] FInt) ptr)
        (getSharedDisplayMode)

public
getWindowPixelFormat : Window -> IO Bits32
getWindowPixelFormat (mkWindow ptr) =
    mkForeign (FFun "SDL_GetWindowPixelFormat" [FPtr] FBits32) ptr

public
data WindowFlag = WindowFullscreen
                | WindowOpengl
                | WindowShown
                | WindowHidden
                | WindowBorderless
                | WindowResizable
                | WindowMinimized
                | WindowMaximized
                | WindowInputGrabbed
                | WindowInputFocus
                | WindowMouseFocus
                | WindowFullscreenDesktop
                | WindowForeign

instance Flag Bits32 WindowFlag where
    toFlag WindowFullscreen        = 0x00000001
    toFlag WindowOpengl            = 0x00000002
    toFlag WindowShown             = 0x00000004
    toFlag WindowHidden            = 0x00000008
    toFlag WindowBorderless        = 0x00000010
    toFlag WindowResizable         = 0x00000020
    toFlag WindowMinimized         = 0x00000040
    toFlag WindowMaximized         = 0x00000080
    toFlag WindowInputGrabbed      = 0x00000100
    toFlag WindowInputFocus        = 0x00000200
    toFlag WindowMouseFocus        = 0x00000400
    toFlag WindowFullscreenDesktop = 0x00000001 `prim__orB32` 0x00001000
    toFlag WindowForeign           = 0x00000800

instance Enumerable WindowFlag where
    enumerate = [WindowFullscreen, WindowOpengl, WindowShown, WindowHidden, WindowBorderless, WindowResizable, WindowMinimized, WindowMaximized, WindowInputGrabbed, WindowInputFocus, WindowMouseFocus, WindowForeign]

--we check if the window was created successfully
checkCreateWindow :  String -> Int -> Int -> Int -> Int -> List WindowFlag -> IO Int
checkCreateWindow title x y w h flags =
    (mkForeign (FFun "idris_SDL_createWindow" [FString, FInt, FInt, FInt, FInt, FBits32] FInt) title x y w h (sumBits flags))

getCreateWindow : IO Window
getCreateWindow = [| mkWindow (mkForeign (FFun "idris_sharedWindow" [] FPtr)) |]

public
createWindow : String -> Int -> Int -> Int -> Int -> List WindowFlag -> IO (Either String Window)
createWindow title x y w h flags = do
    doSDLIf
        (checkCreateWindow title x y w h flags)
        getCreateWindow

public
createWindowFrom : Ptr -> IO (Either String Window)
createWindowFrom ptr = do
    doSDLIf
        (mkForeign (FFun "idris_SDL_createWindowFrom" [FPtr] FInt) ptr)
        [| mkWindow (mkForeign (FFun "idris_SDL_sharedWindow" [] FPtr)) |]

--is 0 a legit return value here?
public
getWindowID : Window -> IO Bits32
getWindowID (mkWindow ptr) =
    mkForeign (FFun "SDL_GetWindowID" [FPtr] FBits32) ptr

public
getWindowFromID : Bits32 -> IO (Either String Window)
getWindowFromID id = do
    doSDLIf
        (mkForeign (FFun "idris_SDL_getWindowFromID" [FBits32] FInt) id)
        [| mkWindow (mkForeign (FFun "idris_sharedWindow" [] FPtr)) |]

--this function might be pure
--fixme return List WindowFlag somehow
public
getWindowFlags : Window -> IO (List WindowFlag)
getWindowFlags (mkWindow ptr) =
    [| bitMaskToFlags (mkForeign (FFun "SDL_GetWindowFlags" [FPtr] FBits32) ptr) |]

public
setWindowTitle : Window -> String -> IO ()
setWindowTitle (mkWindow ptr) title =
    mkForeign (FFun "SDL_SetWindowTitle" [FPtr, FString] FUnit) ptr title

--this function might be pure
public
getWindowTitle : Window -> IO String
getWindowTitle (mkWindow ptr) =
    mkForeign (FFun "SDL_GetWindowTitle" [FPtr] FString) ptr

--does this function indicate when failing?
public
setWindowIcon : Window -> Surface -> IO ()
setWindowIcon (mkWindow win) (mkSurface surf) =
    mkForeign (FFun "SDL_SetWindowIcon" [FPtr, FPtr] FUnit) win surf

--can return a null pointer
public
setWindowData : Window -> String -> Ptr -> IO Ptr
setWindowData (mkWindow win) name value =
    mkForeign (FFun "SDL_SetWindowData" [FPtr, FString, FPtr] FPtr) win name value

--fixme: return Maybe Ptr instead? need to think about whether or not its valid for
--    the user to store a null pointer in a window
public
getWindowData : Window -> String -> IO Ptr
getWindowData (mkWindow win) name =
    mkForeign (FFun "SDL_GetWindowData" [FPtr, FString] FPtr) win name

public
setWindowPosition : Window -> Int -> Int -> IO ()
setWindowPosition (mkWindow ptr) x y =
    mkForeign (FFun "SDL_SetWindowPosition" [FPtr, FInt, FInt] FUnit) ptr x y

getSharedX : IO Int
getSharedX = mkForeign (FFun "idris_shared_x" [] FInt)

getSharedY : IO Int
getSharedY = mkForeign (FFun "idris_shared_y" [] FInt)

public
getWindowPosition : Window -> IO (Int, Int)
getWindowPosition (mkWindow ptr) = do
    mkForeign (FFun "idris_SDL_getWindowPosition" [FPtr] FUnit) ptr
    [| (/*/) getSharedX getSharedY |]

public
setWindowSize : Window -> Int -> Int -> IO ()
setWindowSize (mkWindow ptr) x y =
    mkForeign (FFun "SDL_SetWindowSize" [FPtr, FInt, FInt] FUnit) ptr x y

public
getWindowSize : Window -> IO (Int, Int)
getWindowSize (mkWindow ptr) = do
    mkForeign (FFun "idris_SDL_getWindowSize" [FPtr] FUnit) ptr
    [| (/*/) getSharedX getSharedY |]

public
setWindowMinimumSize : Window -> Int -> Int -> IO ()
setWindowMinimumSize (mkWindow ptr) x y =
    mkForeign (FFun "SDL_SetWindowMinimumSize" [FPtr, FInt, FInt] FUnit) ptr x y

public
getWindowMinimumSize : Window -> IO (Int, Int)
getWindowMinimumSize (mkWindow ptr) = do
    mkForeign (FFun "idris_SDL_getWindowMinimumSize" [FPtr] FUnit) ptr
    [| (/*/) getSharedX getSharedY |]

public
setWindowMaximumSize : Window -> Int -> Int -> IO ()
setWindowMaximumSize (mkWindow ptr) x y =
    mkForeign (FFun "SDL_SetWindowMaximumSize" [FPtr, FInt, FInt] FUnit) ptr x y

public
getWindowMaximumSize : Window -> IO (Int, Int)
getWindowMaximumSize (mkWindow ptr) = do
    mkForeign (FFun "idris_SDL_getWindowMaximumSize" [FPtr] FUnit) ptr
    [| (/*/) getSharedX getSharedY |]

public
setWindowBordered : Window -> Bool -> IO ()
setWindowBordered (mkWindow ptr) bordered =
    mkForeign (FFun "SDL_SetWindowBordered" [FPtr, FInt] FUnit) ptr (toSDLBool bordered)

public
showWindow : Window -> IO ()
showWindow (mkWindow ptr) =
    mkForeign (FFun "SDL_ShowWindow" [FPtr] FUnit) ptr

public
hideWindow : Window -> IO ()
hideWindow (mkWindow ptr) =
    mkForeign (FFun "SDL_HideWindow" [FPtr] FUnit) ptr

public
raiseWindow : Window -> IO ()
raiseWindow (mkWindow ptr) =
    mkForeign (FFun "SDL_RaiseWindow" [FPtr] FUnit) ptr

public
maximizeWindow : Window -> IO ()
maximizeWindow (mkWindow ptr) =
    mkForeign (FFun "SDL_MaximizeWindow" [FPtr] FUnit) ptr

public
minimizeWindow : Window -> IO ()
minimizeWindow (mkWindow ptr) =
    mkForeign (FFun "SDL_MinimizeWindow" [FPtr] FUnit) ptr

public
restoreWindow : Window -> IO ()
restoreWindow (mkWindow ptr) =
    mkForeign (FFun "SDL_RestoreWindow" [FPtr] FUnit) ptr

public
setWindowFullscreen : Window -> Bits32 -> IO (Maybe String)
setWindowFullscreen (mkWindow ptr) flags = do
    doSDL (mkForeign (FFun "SDL_SetWindowFullscreen" [FPtr, FBits32] FInt) ptr flags)

public
getWindowSurface : Window -> IO (Either String Surface)
getWindowSurface (mkWindow ptr) = do
    doSDLIf
        (mkForeign (FFun "idris_SDL_getWindowSurface" [FPtr] FInt) ptr)
        [| mkSurface (mkForeign (FFun "idris_SDL_getWindowSurface_surface" [] FPtr)) |]

public
updateWindowSurface : Window -> IO (Maybe String)
updateWindowSurface (mkWindow ptr) = do
    doSDL (mkForeign (FFun "idris_SDL_getWindowSurface_surface" [] FInt))

public
setWindowGrab : Window -> Bool -> IO ()
setWindowGrab (mkWindow ptr) grabbed =
    mkForeign (FFun "SDL_SetWindowGrab" [FPtr, FInt] FUnit) ptr (toSDLBool grabbed)

public
getWindowGrab : Window -> IO Bool
getWindowGrab (mkWindow ptr) = do
    [| fromSDLBool (mkForeign (FFun "SDL_GetWindowGrab" [FPtr] FInt) ptr) |]

public
setWindowBrightness : Window -> Float -> IO (Maybe String)
setWindowBrightness (mkWindow ptr) brightness = do
    doSDL (mkForeign (FFun "SDL_SetWindowBrightness" [FPtr, FFloat] FInt) ptr brightness)

public
getWindowBrightness : Window -> IO Float
getWindowBrightness (mkWindow ptr) =
    mkForeign (FFun "SDL_GetWindowBrightness" [FPtr] FFloat) ptr

public
destroyWindow : Window -> IO ()
destroyWindow (mkWindow ptr) =
    mkForeign (FFun "SDL_DestroyWindow" [FPtr] FUnit) ptr

public
isScreenSaverEnabled : IO Bool
isScreenSaverEnabled = do
    [| fromSDLBool (mkForeign (FFun "SDL_IsScreenSaverEnabled" [] FInt)) |]

public
enableScreenSaver : IO ()
enableScreenSaver = mkForeign (FFun "SDL_EnableScreenSaver" [] FUnit)

public
disableScreenSaver : IO ()
disableScreenSaver = mkForeign (FFun "SDL_DisableScreenSaver" [] FUnit)

--skipped because of array messiness
--int SDLCALL SDL_UpdateWindowSurfaceRects(SDL_Window * window, const SDL_Rect * rects, int numrects);
--"Each table is an array of 256 16-bit quantities"
--int SDLCALL SDL_SetWindowGammaRamp(SDL_Window * window, const Uint16 * red, const Uint16 * green, const Uint16 * blue);
--int SDLCALL SDL_GetWindowGammaRamp(SDL_Window * window, Uint16 * red, Uint16 * green, Uint16 * blue);

--also skipped: opengl functions
