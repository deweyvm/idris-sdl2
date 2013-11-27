module SDL.Mouse

import SDL.Common
import SDL.Video
import SDL.Surface

%include C "SDL2/SDL_mouse.h"
%include C "SDL/idris_SDL_mouse.h"
%link C "idris_SDL_mouse.o"

data Cursor = mkCursor Ptr

data SystemCursor = SystemCursorArrow
                  | SystemCursorIbeam
                  | SystemCursorWait
                  | SystemCursorCrosshair
                  | SystemCursorWaitarrow
                  | SystemCursorSizenwse
                  | SystemCursorSizenesw
                  | SystemCursorSizewe
                  | SystemCursorSizens
                  | SystemCursorSizeall
                  | SystemCursorNo
                  | SystemCursorHand
                  | NumSystemCursors

instance Flag Bits32 SystemCursor where
    toFlag SystemCursorArrow     = 0x00
    toFlag SystemCursorIbeam     = 0x01
    toFlag SystemCursorWait      = 0x02
    toFlag SystemCursorCrosshair = 0x03
    toFlag SystemCursorWaitarrow = 0x04
    toFlag SystemCursorSizenwse  = 0x05
    toFlag SystemCursorSizenesw  = 0x06
    toFlag SystemCursorSizewe    = 0x07
    toFlag SystemCursorSizens    = 0x08
    toFlag SystemCursorSizeall   = 0x09
    toFlag SystemCursorNo        = 0x0A
    toFlag SystemCursorHand      = 0x0B
    toFlag NumSystemCursors      = 0x0C

--todo - button states

data MouseState = mkMouseState Int Int Bits32

--fixme -- return maybe for null ptr
public
GetMouseFocus : IO Window
GetMouseFocus =
    [| mkWindow (mkForeign (FFun "SDL_GetMouseFocus" [] FPtr)) |]


getSharedX : IO Int
getSharedX = mkForeign (FFun "idris_sharedX_int" [] FInt)

getSharedY : IO Int
getSharedY = mkForeign (FFun "idris_sharedY_int" [] FInt)

getMouseState_state : IO Bits32
getMouseState_state = mkForeign (FFun "idris_SDL_getMouseState_state" [] FBits32)

public
GetMouseState : IO MouseState
GetMouseState = [| mkMouseState getSharedX
                                getSharedY
                                getMouseState_state |]

getRelativeMouseState_state : IO Bits32
getRelativeMouseState_state = mkForeign (FFun "idris_SDL_getRelativeMouseState_state" [] FBits32)

public
GetRelativeMouseState : IO MouseState
GetRelativeMouseState = do
    [| mkMouseState getSharedX
                    getSharedY
                    getRelativeMouseState_state |]

public
WarpMouseInWindow : Window -> Int -> Int -> IO ()
WarpMouseInWindow (mkWindow ptr) x y =
    mkForeign (FFun "SDL_WarpMouseInWindow" [FPtr, FInt, FInt] FUnit) ptr x y

public
SetRelativeMouseMode : Bool -> IO (Maybe String)
SetRelativeMouseMode b =
    trySDL (mkForeign (FFun "SDL_SetRelativeMouseMode" [FInt] FInt) (toSDLBool b))

public
GetRelativeMouseMode : IO Bool
GetRelativeMouseMode =
    [| fromSDLBool (mkForeign (FFun "SDL_GetRelativeMouseMode" [] FInt)) |]

getCursor : IO Cursor
getCursor =
    [| mkCursor (mkForeign (FFun "idris_sharedCursor" [] FPtr)) |]

public
CreateCursor : Ptr -> Ptr -> Int -> Int -> Int -> Int -> IO (Either String Cursor)
CreateCursor data' mask w h hot_x hot_y =
    trySDLRes
        (mkForeign (FFun "idris_SDL_createCursor" [FPtr, FPtr, FInt, FInt, FInt, FInt] FInt) data' mask w h hot_x hot_y)
        getCursor

public
CreateColorCursor : Surface -> Int -> Int -> IO (Either String Cursor)
CreateColorCursor (mkSurface ptr) hot_x hot_y =
    trySDLRes
        (mkForeign (FFun "idris_SDL_createColorCursor" [FPtr, FInt, FInt] FInt) ptr hot_x hot_y)
        getCursor

public
CreateSystemCursor : SystemCursor -> IO (Either String Cursor)
CreateSystemCursor flag =
    trySDLRes
        (mkForeign (FFun "idris_SDL_createSystemCursor" [FBits32] FInt) (toFlag flag))
        getCursor

--fixme, will this set GetError on failure?
public
SetCursor : Cursor -> IO ()
SetCursor (mkCursor ptr) =
    mkForeign (FFun "SDL_SetCursor" [FPtr] FUnit) ptr

public
GetCursor : IO (Either String Cursor)
GetCursor =
    trySDLRes
        (mkForeign (FFun "idris_SDL_getCursor" [] FInt))
        getCursor

public
GetDefaultCursor : IO (Either String Cursor)
GetDefaultCursor =
    trySDLRes
        (mkForeign (FFun "SDL_GetDefaultCursor" [] FInt))
        getCursor

public
FreeCursor : Cursor -> IO ()
FreeCursor (mkCursor ptr) =
    mkForeign (FFun "SDL_FreeCursor" [FPtr] FUnit) ptr

public
IsCursorVisible : IO Bool
IsCursorVisible =
    [| fromSDLBool (mkForeign (FFun "SDL_ShowCursor" [FInt] FInt) (-1)) |]

public
ShowCursor : IO ()
ShowCursor = do
    mkForeign (FFun "SDL_ShowCursor" [FInt] FUnit) 1


public
HideCursor : IO ()
HideCursor = do
    mkForeign (FFun "SDL_ShowCursor" [FInt] FUnit) 0

--skipped for now: event flags
