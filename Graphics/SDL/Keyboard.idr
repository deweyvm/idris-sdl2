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
GetKeyboardFocus : IO (Maybe Window)
GetKeyboardFocus =
    doSDLMaybe
        (mkForeign (FFun "idris_SDL_getKeyboardFocus" [] FInt))
        [| mkWindow (mkForeign (FFun "idris_SDL_getKeyboardFocus_window" [] FPtr)) |]

public
GetKeyboardState : IO (Either String (List Bool))
GetKeyboardState =
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
GetModState : IO (Maybe KeyMod)
GetModState = [| read (mkForeign (FFun "SDL_GetModState" [] FBits32)) |]

public
SetModState : KeyMod -> IO ()
SetModState mod = mkForeign (FFun "SDL_SetModState" [FBits32] FUnit) (toFlag mod)

--probably doesnt need to be SDL call
public
GetKeyFromScancode : ScanCode -> IO (Maybe KeyCode)
GetKeyFromScancode scan =
    [| read (mkForeign (FFun "SDL_GetKeyFromScancode" [FBits32] FBits32) (toFlag scan)) |]

--probably doesnt need to be SDL call
public
GetScancodeFromKey : KeyCode -> IO (Maybe ScanCode)
GetScancodeFromKey key =
    [| read (mkForeign (FFun "SDL_GetScancodeFromKey" [FBits32] FBits32) (toFlag key)) |]

public
GetScancodeName : ScanCode -> IO String
GetScancodeName scan = mkForeign (FFun "SDL_GetScancodeName" [FBits32] FString) (toFlag scan)

public
GetScancodeFromName : String -> IO ScanCode
GetScancodeFromName name =
    [| (readOrElse ScanCode.Unknown) (mkForeign (FFun "SDL_GetScancodeFromName" [FString] FBits32) name) |]

public
GetKeyName : KeyCode -> IO String
GetKeyName key = mkForeign (FFun "SDL_GetKeyName" [FBits32] FString) (toFlag key)

public
GetKeyFromName : String -> IO KeyCode
GetKeyFromName name =
    [| (readOrElse KeyCode.Unknown) (mkForeign (FFun "SDL_GetKeyFromName" [FString] FBits32) name) |]

public
StartTextInput : IO ()
StartTextInput = mkForeign (FFun "SDL_StartTextInput" [] FUnit)

public
IsTextInputActive : IO Bool
IsTextInputActive =
    [| fromSDLBool (mkForeign (FFun "SDL_IsTextInputActive" [] FInt)) |]

public
StopTextInput : IO ()
StopTextInput = mkForeign (FFun "SDL_StopTextInput" [] FUnit)

public
SetTextInputRect : Rect -> IO ()
SetTextInputRect (mkRect x y w h) =
    mkForeign (FFun "idris_SDL_setTextInputRect" [FInt, FInt, FInt, FInt] FUnit) x y w h

public
HasScreenKeyboardSupport : IO Bool
HasScreenKeyboardSupport =
    [| fromSDLBool (mkForeign (FFun "SDL_HasScreenKeyboardSupport" [] FInt)) |]

public
IsScreenKeyboardShown : Window -> Bool
IsScreenKeyboardShown (mkWindow win) =
    [| fromSDLBool (mkForeign (FFun "SDL_IsScreenKeyboardShown" [FPtr] FInt) win) |]
