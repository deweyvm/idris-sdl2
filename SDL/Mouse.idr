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
GetMouseFocus = [| mkWindow (mkForeign (FFun "SDL_GetMouseFocus" [] FPtr)) |]

getMouseState_x : IO Int
getMouseState_x = mkForeign (FFun "idris_SDL_GetMouseState_x" [] FInt)

getMouseState_y : IO Int
getMouseState_y = mkForeign (FFun "idris_SDL_GetMouseState_y" [] FInt)

getMouseState_state : IO Bits32
getMouseState_state = mkForeign (FFun "idris_SDL_GetMouseState_state" [] FBits32)

public
GetMouseState : IO MouseState
GetMouseState = [| mkMouseState getMouseState_x
                                getMouseState_y
                                getMouseState_state |]


getRelativeMouseState_x : IO Int
getRelativeMouseState_x = mkForeign (FFun "idris_SDL_GetRelativeMouseState_x" [] FInt)

getRelativeMouseState_y : IO Int
getRelativeMouseState_y = mkForeign (FFun "idris_SDL_GetRelativeMouseState_y" [] FInt)

getRelativeMouseState_state : IO Bits32
getRelativeMouseState_state = mkForeign (FFun "idris_SDL_GetRelativeMouseState_state" [] FBits32)

public
GetRelativeMouseState : IO MouseState
GetRelativeMouseState = do
    [| mkMouseState getRelativeMouseState_x
                    getRelativeMouseState_y
                    getRelativeMouseState_state |]

public
WarpMouseInWindow : Window -> Int -> Int -> IO ()
WarpMouseInWindow (mkWindow ptr) x y =
    mkForeign (FFun "SDL_WarpMouseInWindow" [FPtr, FInt, FInt] FUnit) ptr x y

--fixme - maybe return an error string here if it fails?
--        need to check sdl's behavior
public
SetRelativeMouseMode : Bool -> IO Bool
SetRelativeMouseMode b = [| fromSDLBool (mkForeign (FFun "SDL_SetRelativeMouseMode" [FInt] FInt) (toSDLBool b)) |]

public
GetRelativeMouseMode : IO Bool
GetRelativeMouseMode = [| fromSDLBool (mkForeign (FFun "SDL_GetRelativeMouseMode" [] FInt)) |]

public
CreateCursor : Ptr -> Ptr -> Int -> Int -> Int -> Int -> IO Cursor
CreateCursor data' mask w h hot_x hot_y =
    [| mkCursor (mkForeign (FFun "SDL_CreateCursor" [FPtr, FPtr, FInt, FInt, FInt, FInt] FPtr) data' mask w h hot_x hot_y) |]

public
CreateColorCursor : Surface -> Int -> Int -> IO Cursor
CreateColorCursor (mkSurface ptr) hot_x hot_y =
    [| mkCursor (mkForeign (FFun "SDL_CreateColorCursor" [FPtr, FInt, FInt] FPtr) ptr hot_x hot_y) |]

public
CreateSystemCursor : SystemCursor -> IO Cursor
CreateSystemCursor flag =
    [| mkCursor (mkForeign (FFun "SDL_CreateSystemCursor" [FBits32] FPtr) (toFlag flag)) |]


public
SetCursor : Cursor -> IO ()
SetCursor (mkCursor ptr) =
    mkForeign (FFun "SDL_SetCursor" [FPtr] FUnit) ptr

--fixme, may return NULL
public
GetCursor : IO Cursor {- Either String Cursor-}
GetCursor = [| mkCursor (mkForeign (FFun "SDL_GetCursor" [] FPtr)) |]

--fixme, may return NULL
public
GetDefaultCursor : IO Cursor {- Either String Cursor-}
GetDefaultCursor = [| mkCursor (mkForeign (FFun "SDL_GetDefaultCursor" [] FPtr)) |]

public
FreeCursor : Cursor -> IO ()
FreeCursor (mkCursor ptr) =
    mkForeign (FFun "SDL_FreeCursor" [FPtr] FUnit) ptr

public
IsCursorVisible : IO Bool
IsCursorVisible = [| fromSDLBool (mkForeign (FFun "SDL_ShowCursor" [FInt] FInt) (-1)) |]

public
ShowCursor : IO ()
ShowCursor = do
    mkForeign (FFun "SDL_ShowCursor" [FInt] FUnit) 1


public
HideCursor : IO ()
HideCursor = do
    mkForeign (FFun "SDL_ShowCursor" [FInt] FUnit) 0

--skipped for now: event flags
