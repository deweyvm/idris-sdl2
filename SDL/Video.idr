module SDL.Video

import SDL.Common
import SDL.SDL
import SDL.Rect
import Data.Bits

%include C "SDL2/SDL_video.h"
%include C "SDL/idris_SDL_video.h"
%link C "idris_SDL_video.o"

--a window must never be null. We must assure through our C wrapper that a null
-- pointer is never passed to mkWindow
--fixme: should be abstract
public
data Window = mkWindow Ptr

instance Show Window where
    show x = "Window"

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

--fixme
public
GetDisplayBounds : Int -> IO (Either String Rect)
GetDisplayBounds index = do
    trySDLRes
        (checkGetDisplayBounds index)
        [| mkRect getDisplayBounds_x
                  getDisplayBounds_y
                  getDisplayBounds_w
                  getDisplayBounds_h |]


public
GetNumDisplayModes : Int -> IO Int
GetNumDisplayModes index = mkForeign (FFun "SDL_GetNumDisplayModes" [FInt] FInt) index

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
GetDisplayMode : Int -> Int -> IO (Either String DisplayMode)
GetDisplayMode displayIndex modeIndex = do
    trySDLRes
        (checkGetDisplayMode displayIndex modeIndex)
        (getSharedDisplayMode)

checkGetDesktopDisplayMode : Int -> IO Int
checkGetDesktopDisplayMode displayIndex =
    mkForeign (FFun "idris_SDL_getDesktopDisplayMode" [FInt] FInt) displayIndex

public
GetDesktopDisplayMode : Int -> IO (Either String DisplayMode)
GetDesktopDisplayMode displayIndex = do
    trySDLRes
        (checkGetDesktopDisplayMode displayIndex)
        (getSharedDisplayMode)

checkGetCurrentDisplayMode : Int -> IO Int
checkGetCurrentDisplayMode displayIndex =
    mkForeign (FFun "idris_SDL_getCurrentDisplayMode" [FInt] FInt) displayIndex

public
GetCurrentDisplayMode : Int -> IO (Either String DisplayMode)
GetCurrentDisplayMode displayIndex = do
    trySDLRes
        (checkGetCurrentDisplayMode displayIndex)
        (getSharedDisplayMode)

public
GetClosestDisplayMode : Int -> DisplayMode -> IO (Either String DisplayMode)
GetClosestDisplayMode displayIndex (mkDisplayMode format w h hz ddata) = do
    trySDLRes
        (mkForeign (FFun "idris_SDL_getClosestDisplayMode" [FInt, FBits32, FInt, FInt, FInt, FPtr] FInt) displayIndex format w h hz ddata)
        (getSharedDisplayMode)

public
GetWindowDisplayIndex : Window -> IO (Maybe Int)
GetWindowDisplayIndex (mkWindow ptr) = do
    index <- mkForeign (FFun "SDL_GetWindowDisplayIndex" [FPtr] FInt) ptr
    return $ case index of
      -1 => Nothing
      n  => Just n

public
SetWindowDisplayMode : Window -> DisplayMode -> IO (Maybe String)
SetWindowDisplayMode (mkWindow ptr) (mkDisplayMode format w h hz ddata) = do
    trySDL (mkForeign (FFun "idris_SDL_setWindowDisplayMode" [FPtr, FBits32, FInt, FInt, FInt, FPtr] FInt) ptr format w h hz ddata)

public
GetWindowDisplayMode : Window -> IO (Either String DisplayMode)
GetWindowDisplayMode (mkWindow ptr) = do
    trySDLRes
        (mkForeign (FFun "idris_SDL_getWindowDisplayMode" [FPtr] FInt) ptr)
        (getSharedDisplayMode)

public
GetWindowPixelFormat : Window -> IO Bits32
GetWindowPixelFormat (mkWindow ptr) =
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
    toFlag WindowFullscreenDesktop = (toFlag WindowFullscreen) `prim__orB32` 0x00001000
    toFlag WindowForeign           = 0x00000800

--we check if the window was created successfully
checkCreateWindow :  String -> Int -> Int -> Int -> Int -> List WindowFlag -> IO Int
checkCreateWindow title x y w h flags =
    (mkForeign (FFun "idris_SDL_CreateWindow" [FString, FInt, FInt, FInt, FInt, FBits32] FInt) title x y w h (sumBits flags))

getCreateWindow : IO Window
getCreateWindow = mkWindow `map` (mkForeign (FFun "idris_sharedWindow" [] FPtr))

public
CreateWindow : String -> Int -> Int -> Int -> Int -> List WindowFlag -> IO (Either String Window)
CreateWindow title x y w h flags = do
    trySDLRes
        (checkCreateWindow title x y w h flags)
        getCreateWindow

public
CreateWindowFrom : Ptr -> IO (Either String Window)
CreateWindowFrom ptr = do
    trySDLRes
        (mkForeign (FFun "idris_SDL_createWindowFrom" [FPtr] FInt) ptr)
        (mkWindow `map` (mkForeign (FFun "idris_SDL_sharedWindow" [] FPtr)))

--is 0 a legit return value here?
public
GetWindowID : Window -> IO Bits32
GetWindowID (mkWindow ptr) =
    mkForeign (FFun "SDL_GetWindowID" [FPtr] FBits32) ptr

public
GetWindowFromID : Bits32 -> IO (Either String Window)
GetWindowFromID id = do
    trySDLRes
        (mkForeign (FFun "idris_SDL_getWindowFromID" [FBits32] FInt) id)
        (mkWindow `map` (mkForeign (FFun "idris_sharedWindow" [] FPtr)))

--this function might be pure
--fixme return List WindowFlag somehow
public
GetWindowFlags : Window -> IO Bits32
GetWindowFlags (mkWindow ptr) =
    mkForeign (FFun "SDL_GetWindowFlags" [FPtr] FBits32) ptr

public
SetWindowTitle : Window -> String -> IO ()
SetWindowTitle (mkWindow ptr) title =
    mkForeign (FFun "SDL_SetWindowTitle" [FPtr, FString] FUnit) ptr title

--this function might be pure
public
GetWindowTitle : Window -> IO String
GetWindowTitle (mkWindow ptr) =
    mkForeign (FFun "SDL_GetWindowTitle" [FPtr] FString) ptr

--does this function indicate when failing?
public
SetWindowIcon : Window -> Surface -> IO ()
SetWindowIcon (mkWindow win) (mkSurface surf) =
    mkForeign (FFun "SDL_SetWindowIcon" [FPtr, FPtr] FUnit) win surf

--can return a null pointer
public
SetWindowData : Window -> String -> Ptr -> IO Ptr
SetWindowData (mkWindow win) name value =
    mkForeign (FFun "SDL_SetWindowData" [FPtr, FString, FPtr] FPtr) win name value

--fixme: return Maybe Ptr instead? need to think about whether or not its valid for
--    the user to store a null pointer in a window
public
GetWindowData : Window -> String -> IO Ptr
GetWindowData (mkWindow win) name =
    mkForeign (FFun "SDL_GetWindowData" [FPtr, FString] FPtr) win name

public
SetWindowPosition : Window -> Int -> Int -> IO ()
SetWindowPosition (mkWindow ptr) x y =
    mkForeign (FFun "SDL_SetWindowPosition" [FPtr, FInt, FInt] FUnit) ptr x y

getSharedX : IO Int
getSharedX = mkForeign (FFun "idris_shared_x" [] FInt)

getSharedY : IO Int
getSharedY = mkForeign (FFun "idris_shared_y" [] FInt)

public
GetWindowPosition : Window -> IO (Int, Int)
GetWindowPosition (mkWindow ptr) = do
    mkForeign (FFun "idris_SDL_getWindowPosition" [FPtr] FUnit) ptr
    [| (<*->) getSharedX getSharedY |]

public
SetWindowSize : Window -> Int -> Int -> IO ()
SetWindowSize (mkWindow ptr) x y =
    mkForeign (FFun "SDL_SetWindowSize" [FPtr, FInt, FInt] FUnit) ptr x y

public
GetWindowSize : Window -> IO (Int, Int)
GetWindowSize (mkWindow ptr) = do
    mkForeign (FFun "idris_SDL_getWindowSize" [FPtr] FUnit) ptr
    [| (<*->) getSharedX getSharedY |]

public
SetWindowMinimumSize : Window -> Int -> Int -> IO ()
SetWindowMinimumSize (mkWindow ptr) x y =
    mkForeign (FFun "SDL_SetWindowMinimumSize" [FPtr, FInt, FInt] FUnit) ptr x y

public
GetWindowMinimumSize : Window -> IO (Int, Int)
GetWindowMinimumSize (mkWindow ptr) = do
    mkForeign (FFun "idris_SDL_getWindowMinimumSize" [FPtr] FUnit) ptr
    [| (<*->) getSharedX getSharedY |]

public
SetWindowMaximumSize : Window -> Int -> Int -> IO ()
SetWindowMaximumSize (mkWindow ptr) x y =
    mkForeign (FFun "SDL_SetWindowMaximumSize" [FPtr, FInt, FInt] FUnit) ptr x y

public
GetWindowMaximumSize : Window -> IO (Int, Int)
GetWindowMaximumSize (mkWindow ptr) = do
    mkForeign (FFun "idris_SDL_getWindowMaximumSize" [FPtr] FUnit) ptr
    [| (<*->) getSharedX getSharedY |]

public
SetWindowBordered : Window -> Bool -> IO ()
SetWindowBordered (mkWindow ptr) bordered =
    mkForeign (FFun "SDL_SetWindowBordered" [FPtr, FInt] FUnit) ptr (toSDLBool bordered)

public
ShowWindow : Window -> IO ()
ShowWindow (mkWindow ptr) =
    mkForeign (FFun "SDL_ShowWindow" [FPtr] FUnit) ptr

public
HideWindow : Window -> IO ()
HideWindow (mkWindow ptr) =
    mkForeign (FFun "SDL_HideWindow" [FPtr] FUnit) ptr

public
RaiseWindow : Window -> IO ()
RaiseWindow (mkWindow ptr) =
    mkForeign (FFun "SDL_RaiseWindow" [FPtr] FUnit) ptr

public
MaximizeWindow : Window -> IO ()
MaximizeWindow (mkWindow ptr) =
    mkForeign (FFun "SDL_MaximizeWindow" [FPtr] FUnit) ptr

public
MinimizeWindow : Window -> IO ()
MinimizeWindow (mkWindow ptr) =
    mkForeign (FFun "SDL_MinimizeWindow" [FPtr] FUnit) ptr

public
RestoreWindow : Window -> IO ()
RestoreWindow (mkWindow ptr) =
    mkForeign (FFun "SDL_RestoreWindow" [FPtr] FUnit) ptr

public
SetWindowFullscreen : Window -> Bits32 -> IO (Maybe String)
SetWindowFullscreen (mkWindow ptr) flags = do
    trySDL (mkForeign (FFun "SDL_SetWindowFullscreen" [FPtr, FBits32] FInt) ptr flags)

public
GetWindowSurface : Window -> IO (Either String Surface)
GetWindowSurface (mkWindow ptr) = do
    trySDLRes
        (mkForeign (FFun "idris_SDL_getWindowSurface" [FPtr] FInt) ptr)
        (mkSurface `map` mkForeign (FFun "idris_SDL_getWindowSurface_surface" [] FPtr))

public
UpdateWindowSurface : Window -> IO (Maybe String)
UpdateWindowSurface (mkWindow ptr) = do
    trySDL (mkForeign (FFun "idris_SDL_getWindowSurface_surface" [] FInt))

public
SetWindowGrab : Window -> Bool -> IO ()
SetWindowGrab (mkWindow ptr) grabbed =
    mkForeign (FFun "SDL_SetWindowGrab" [FPtr, FInt] FUnit) ptr (toSDLBool grabbed)

public
GetWindowGrab : Window -> IO Bool
GetWindowGrab (mkWindow ptr) = do
    [| fromSDLBool (mkForeign (FFun "SDL_GetWindowGrab" [FPtr] FInt) ptr) |]

--fixme
public
SetWindowBrightness : Window -> Float -> IO (Maybe String)
SetWindowBrightness (mkWindow ptr) brightness = do
    trySDL (mkForeign (FFun "SDL_SetWindowBrightness" [FPtr, FFloat] FInt) ptr brightness)

public
GetWindowBrightness : Window -> IO Float
GetWindowBrightness (mkWindow ptr) =
    mkForeign (FFun "SDL_GetWindowBrightness" [FPtr] FFloat) ptr

public
DestroyWindow : Window -> IO ()
DestroyWindow (mkWindow ptr) =
    mkForeign (FFun "SDL_DestroyWindow" [FPtr] FUnit) ptr

public
IsScreenSaverEnabled : IO Bool
IsScreenSaverEnabled = do
    [| fromSDLBool (mkForeign (FFun "SDL_IsScreenSaverEnabled" [] FInt)) |]

public
EnableScreenSaver : IO ()
EnableScreenSaver = mkForeign (FFun "SDL_EnableScreenSaver" [] FUnit)

public
DisableScreenSaver : IO ()
DisableScreenSaver = mkForeign (FFun "SDL_DisableScreenSaver" [] FUnit)

--skipped because of array messiness
--int SDLCALL SDL_UpdateWindowSurfaceRects(SDL_Window * window, const SDL_Rect * rects, int numrects);
--"Each table is an array of 256 16-bit quantities"
--int SDLCALL SDL_SetWindowGammaRamp(SDL_Window * window, const Uint16 * red, const Uint16 * green, const Uint16 * blue);
--int SDLCALL SDL_GetWindowGammaRamp(SDL_Window * window, Uint16 * red, Uint16 * green, Uint16 * blue);

--also skipped: opengl functions