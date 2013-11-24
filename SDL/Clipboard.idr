module SDL.Clipboard

import SDL.SDL

%include C "SDL2/SDL_clipboard.h"
%include C "SDL/idris_SDL_clipboard.h"
%link C "idris_SDL_clipboard.o"

public
SetClipboardText : String -> IO (Maybe String)
SetClipboardText text = do
    err <- mkForeign (FFun "SDL_SetClipboardText" [FString] FInt) text
    if (err /= 0)
      then do
        errorString <- GetError
        return $ Just errorString
      else
        return Nothing

public
HasClipboardText : IO Bool
HasClipboardText = do
    [| fromSDLBool (mkForeign (FFun "SDL_HasClipboardText" [] FInt)) |]

--this segfaults if there is no window
public
GetClipboardText : IO (Either String String)
GetClipboardText = do
    hasText <- HasClipboardText
    if (not hasText)
       then
         return $ Left "<empty>"
       else do
         success <- [| fromSDLBool (mkForeign (FFun "idris_SDL_getClipboardText" [] FInt)) |]
         if (not success)
           then do
             errorString <- GetError
             return $ Left errorString
           else do
             contents <- mkForeign (FFun "idris_SDL_getClipboardText_string" [] FString)
             mkForeign (FFun "idris_SDL_getClipboardText_free" [] FUnit)
             return $ Right contents


