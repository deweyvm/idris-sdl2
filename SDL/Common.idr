module Common

%lib C "SDL2"

%include C "SDL2/SDL.h"
%include C "SDL2/SDL_rect.h"
%include C "SDL2/SDL_video.h"

fromSDLBool : Int -> Bool
fromSDLBool 0 = False
fromSDLBool _ = True

toSDLBool : Bool -> Int
toSDLBool True = 1
toSDLBool False = 0

(<**>) : a -> a -> a -> (a, a, a)
(<**>) x y z = (x, y, z)
