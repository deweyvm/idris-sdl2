module Graphics.SDL.Mouse

import Graphics.SDL.Common
import Graphics.SDL.Video
import Graphics.SDL.Surface

%include C "SDL2/SDL_mouse.h"
%include C "csrc/idris_SDL_mouse.h"
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
getMouseFocus : IO Window
getMouseFocus =
    [| mkWindow (mkForeign (FFun "SDL_GetMouseFocus" [] FPtr)) |]


getSharedX : IO Int
getSharedX = mkForeign (FFun "idris_sharedX_int" [] FInt)

getSharedY : IO Int
getSharedY = mkForeign (FFun "idris_sharedY_int" [] FInt)

getMouseState_state : IO Bits32
getMouseState_state = mkForeign (FFun "idris_SDL_getMouseState_state" [] FBits32)

public
getMouseState : IO MouseState
getMouseState = [| mkMouseState getSharedX
                                getSharedY
                                getMouseState_state |]

getRelativeMouseState_state : IO Bits32
getRelativeMouseState_state = mkForeign (FFun "idris_SDL_getRelativeMouseState_state" [] FBits32)

public
getRelativeMouseState : IO MouseState
getRelativeMouseState = do
    [| mkMouseState getSharedX
                    getSharedY
                    getRelativeMouseState_state |]

public
warpMouseInWindow : Window -> Int -> Int -> IO ()
warpMouseInWindow (mkWindow ptr) x y =
    mkForeign (FFun "SDL_WarpMouseInWindow" [FPtr, FInt, FInt] FUnit) ptr x y

public
setRelativeMouseMode : Bool -> IO (Maybe String)
setRelativeMouseMode b =
    doSDL (mkForeign (FFun "SDL_SetRelativeMouseMode" [FInt] FInt) (toSDLBool b))

public
getRelativeMouseMode : IO Bool
getRelativeMouseMode =
    [| fromSDLBool (mkForeign (FFun "SDL_GetRelativeMouseMode" [] FInt)) |]

getCursor' : IO Cursor
getCursor' =
    [| mkCursor (mkForeign (FFun "idris_sharedCursor" [] FPtr)) |]

public
createCursor : Ptr -> Ptr -> Int -> Int -> Int -> Int -> IO (Either String Cursor)
createCursor data' mask w h hot_x hot_y =
    doSDLIf
        (mkForeign (FFun "idris_SDL_createCursor" [FPtr, FPtr, FInt, FInt, FInt, FInt] FInt) data' mask w h hot_x hot_y)
        getCursor'

public
createColorCursor : Surface -> Int -> Int -> IO (Either String Cursor)
createColorCursor (mkSurface ptr) hot_x hot_y =
    doSDLIf
        (mkForeign (FFun "idris_SDL_createColorCursor" [FPtr, FInt, FInt] FInt) ptr hot_x hot_y)
        getCursor'

public
createSystemCursor : SystemCursor -> IO (Either String Cursor)
createSystemCursor flag =
    doSDLIf
        (mkForeign (FFun "idris_SDL_createSystemCursor" [FBits32] FInt) (toFlag flag))
        getCursor'

--fixme, will this set GetError on failure?
public
setCursor : Cursor -> IO ()
setCursor (mkCursor ptr) =
    mkForeign (FFun "SDL_SetCursor" [FPtr] FUnit) ptr

public
getCursor : IO (Either String Cursor)
getCursor =
    doSDLIf
        (mkForeign (FFun "idris_SDL_getCursor" [] FInt))
        getCursor'

public
getDefaultCursor : IO (Either String Cursor)
getDefaultCursor =
    doSDLIf
        (mkForeign (FFun "SDL_GetDefaultCursor" [] FInt))
        getCursor'

public
freeCursor : Cursor -> IO ()
freeCursor (mkCursor ptr) =
    mkForeign (FFun "SDL_FreeCursor" [FPtr] FUnit) ptr

public
isCursorVisible : IO Bool
isCursorVisible =
    [| fromSDLBool (mkForeign (FFun "SDL_ShowCursor" [FInt] FInt) (-1)) |]

public
showCursor : IO ()
showCursor = do
    mkForeign (FFun "SDL_ShowCursor" [FInt] FUnit) 1


public
hideCursor : IO ()
hideCursor = do
    mkForeign (FFun "SDL_ShowCursor" [FInt] FUnit) 0

--skipped for now: event flags
