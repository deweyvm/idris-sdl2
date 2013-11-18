module SDL.Rect

import SDL.Common

data Rect = mkRect Int Int Int Int

instance Show Rect where
    show (mkRect x y w h) = "Rect " ++ (show x) ++ " " ++ (show y) ++ " " ++ (show w) ++ " " ++ (show h)

RectEmpty : Rect -> Bool
RectEmpty (mkRect x y w h) = w <= 0 || h <= 0

RectEquals : Rect -> Rect -> Bool
RectEquals (mkRect x1 y1 w1 h1) (mkRect x2 y2 w2 h2) = 
    (x1 == x2) && (y1 == y2) && (w1 == w2) && (h1 == h2)

