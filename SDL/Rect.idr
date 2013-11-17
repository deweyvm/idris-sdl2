module SDL.Rect

import SDL.Common

data Rect = mkRect Int Int Int Int

instance Show Rect where
    show (mkRect x y w h) = "rect"

RectEmpty : Rect -> Bool
RectEmpty r = True