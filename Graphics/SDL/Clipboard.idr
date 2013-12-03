module Graphics.SDL.Clipboard

import Graphics.SDL.SDL

%include C "SDL2/SDL_clipboard.h"
%include C "csrc/idris_SDL_clipboard.h"
%link C "idris_SDL_clipboard.o"

public
setClipboardText : String -> IO (Maybe String)
setClipboardText text = do
    doSDL (mkForeign (FFun "SDL_SetClipboardText" [FString] FInt) text)

public
hasClipboardText : IO Bool
hasClipboardText = do
    [| fromSDLBool (mkForeign (FFun "SDL_HasClipboardText" [] FInt)) |]

--this segfaults if there is no window, even with our check
--fixme
public
getClipboardText : IO (Either String String)
getClipboardText = do
    hasText <- hasClipboardText
    if (not hasText)
       then
         return $ Left "<empty>"
       else do
         doSDLIf
             (mkForeign (FFun "idris_SDL_getClipboardText" [] FInt))
             (mkForeign (FFun "idris_SDL_getClipboardText_string" [] FString)
                <$ mkForeign (FFun "idris_SDL_getClipboardText_free" [] FUnit))



