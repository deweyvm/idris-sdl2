module SDL.Mouse

import SDL.Common
import SDL.Video

%include C "SDL2/SDL_mouse.h"
%include C "SDL/idris_SDL_mouse.h"
%link C "idris_SDL_mouse.o"

data Cursor = mkCursor Ptr

class Flag a where
    toBits : a -> Bits32

{-intToBool : Int -> Bool
intToBool 0 = False
intToBool _ = True
-}
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

instance Flag SystemCursor where
    toBits SystemCursorArrow     = 0x00
    toBits SystemCursorIbeam     = 0x01
    toBits SystemCursorWait      = 0x02
    toBits SystemCursorCrosshair = 0x03
    toBits SystemCursorWaitarrow = 0x04
    toBits SystemCursorSizenwse  = 0x05
    toBits SystemCursorSizenesw  = 0x06
    toBits SystemCursorSizewe    = 0x07
    toBits SystemCursorSizens    = 0x08
    toBits SystemCursorSizeall   = 0x09
    toBits SystemCursorNo        = 0x0A
    toBits SystemCursorHand      = 0x0B
    toBits NumSystemCursors      = 0x0C

--fixme -- return maybe for null ptr
public
GetMouseFocus : IO Window
GetMouseFocus = mkWindow `map` (mkForeign (FFun "SDL_GetMouseFocus" [] FPtr))

--fixme - lossy coersion from Uint32 to Int
getMouseState_state : IO Int
getMouseState_state = mkForeign (FFun "idris_SDL_GetMouseState_state" [] FInt)

getMouseState_x : IO Int
getMouseState_x = mkForeign (FFun "idris_SDL_GetMouseState_x" [] FInt)

getMouseState_y : IO Int
getMouseState_y = mkForeign (FFun "idris_SDL_GetMouseState_y" [] FInt)

public
GetMouseState : IO (Int, Int, {-Bits32-}Int)
GetMouseState = do
    state <- getMouseState_state
    x <- getMouseState_x
    y <- getMouseState_y --todo, make function to map (, ,) over IO
    return (x, y, state)

--fixme - lossy coersion from Uint32 to Int
getRelativeMouseState_state : IO Int
getRelativeMouseState_state = mkForeign (FFun "idris_SDL_GetRelativeMouseState_state" [] FInt)

getRelativeMouseState_x : IO Int
getRelativeMouseState_x = mkForeign (FFun "idris_SDL_GetRelativeMouseState_x" [] FInt)

getRelativeMouseState_y : IO Int
getRelativeMouseState_y = mkForeign (FFun "idris_SDL_GetRelativeMouseState_y" [] FInt)

com2 : a -> a -> a -> (a, a, a)
com2 x y z = (x, y, z)

public
GetRelativeMouseState : IO (Int, Int, {-Bits32-}Int)
GetRelativeMouseState = do
    {-state <- getRelativeMouseState_state
    x <- getRelativeMouseState_x
    y <- getRelativeMouseState_y --todo, make function to map (, ,) over IO
    return [| (x, y, state) |]-}
    [| com2 getRelativeMouseState_x getRelativeMouseState_y getRelativeMouseState_state |]

public
GetRelativeMouseMode : IO Bool
GetRelativeMouseMode = intToBool `map` (mkForeign (FFun "idris_SDL_GetRelativeMouseMode" [] FInt))