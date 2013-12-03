module Graphics.SDL.Keyboard

import Graphics.SDL.Common
import Graphics.SDL.ScanCode
import Graphics.SDL.KeyCode
import Utils.Map

%include C "SDL2/SDL_keyboard.h"
%include C "csrc/idris_SDL_keyboard.h"
%link C "idris_SDL_keyboard.o"


public
data KeySym = mkKeySym ScanCode KeyCode (List KeyMod)



public
getKeyboardFocus : IO (Maybe Window)
getKeyboardFocus =
    doSDLMaybe
        (mkForeign (FFun "idris_SDL_getKeyboardFocus" [] FInt))
        [| mkWindow (mkForeign (FFun "idris_SDL_getKeyboardFocus_window" [] FPtr)) |]

public
getKeyboardState : IO (Either String (List Bool))
getKeyboardState =
    doSDLIf
      (mkForeign (FFun "idris_SDL_getKeyboardState" [] FInt))
      (do length <- mkForeign (FFun "idris_getKeyboardState_length" [] FInt)
          getArray length)
  where
    getArray : Int -> IO (List Bool)
    getArray i = sequence (map getBool [0..i])
      where
        getBool : Int -> IO Bool
        getBool _ = fromSDLBool `map` (mkForeign (FFun "idris_getKeyboardState_keystate" [] FInt))

public
getModState : IO (Maybe KeyMod)
getModState = [| read (mkForeign (FFun "SDL_GetModState" [] FBits32)) |]

public
setModState : KeyMod -> IO ()
setModState mod = mkForeign (FFun "SDL_SetModState" [FBits32] FUnit) (toFlag mod)

--probably doesnt need to be SDL call
public
getKeyFromScancode : ScanCode -> IO (Maybe KeyCode)
getKeyFromScancode scan =
    [| read (mkForeign (FFun "SDL_GetKeyFromScancode" [FBits32] FBits32) (toFlag scan)) |]

--probably doesnt need to be SDL call
public
getScancodeFromKey : KeyCode -> IO (Maybe ScanCode)
getScancodeFromKey key =
    [| read (mkForeign (FFun "SDL_GetScancodeFromKey" [FBits32] FBits32) (toFlag key)) |]

public
getScancodeName : ScanCode -> IO String
getScancodeName scan = mkForeign (FFun "SDL_GetScancodeName" [FBits32] FString) (toFlag scan)

public
getScancodeFromName : String -> IO ScanCode
getScancodeFromName name =
    [| (readOrElse ScanCode.Unknown) (mkForeign (FFun "SDL_GetScancodeFromName" [FString] FBits32) name) |]

public
getKeyName : KeyCode -> IO String
getKeyName key = mkForeign (FFun "SDL_GetKeyName" [FBits32] FString) (toFlag key)

public
getKeyFromName : String -> IO KeyCode
getKeyFromName name =
    [| (readOrElse KeyCode.Unknown) (mkForeign (FFun "SDL_GetKeyFromName" [FString] FBits32) name) |]

public
startTextInput : IO ()
startTextInput = mkForeign (FFun "SDL_StartTextInput" [] FUnit)

public
isTextInputActive : IO Bool
isTextInputActive =
    [| fromSDLBool (mkForeign (FFun "SDL_IsTextInputActive" [] FInt)) |]

public
stopTextInput : IO ()
stopTextInput = mkForeign (FFun "SDL_StopTextInput" [] FUnit)

public
setTextInputRect : Rect -> IO ()
setTextInputRect (mkRect x y w h) =
    mkForeign (FFun "idris_SDL_setTextInputRect" [FInt, FInt, FInt, FInt] FUnit) x y w h

public
hasScreenKeyboardSupport : IO Bool
hasScreenKeyboardSupport =
    [| fromSDLBool (mkForeign (FFun "SDL_HasScreenKeyboardSupport" [] FInt)) |]

public
isScreenKeyboardShown : Window -> IO Bool
isScreenKeyboardShown (mkWindow win) =
    [| fromSDLBool (mkForeign (FFun "SDL_IsScreenKeyboardShown" [FPtr] FInt) win) |]
