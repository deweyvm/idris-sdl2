module Graphics.SDL.Clipboard

import Graphics.SDL.SDL

%include C "SDL2/SDL_clipboard.h"
%include C "csrc/idris_SDL_clipboard.h"
%link C "idris_SDL_clipboard.o"

public
SetClipboardText : String -> IO (Maybe String)
SetClipboardText text = do
    doSDL (mkForeign (FFun "SDL_SetClipboardText" [FString] FInt) text)

public
HasClipboardText : IO Bool
HasClipboardText = do
    [| fromSDLBool (mkForeign (FFun "SDL_HasClipboardText" [] FInt)) |]

--this segfaults if there is no window
--fixme
public
GetClipboardText : IO (Either String String)
GetClipboardText = do
    hasText <- HasClipboardText
    if (not hasText)
       then
         return $ Left "<empty>"
       else do
         doSDLIf
             (mkForeign (FFun "idris_SDL_getClipboardText" [] FInt))
             (mkForeign (FFun "idris_SDL_getClipboardText_string" [] FString)
                <$ mkForeign (FFun "idris_SDL_getClipboardText_free" [] FUnit))



