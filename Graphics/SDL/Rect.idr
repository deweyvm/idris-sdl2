module Graphics.SDL.Rect

import Graphics.SDL.Common

data Rect = MkRect Int Int Int Int
data Point = MkPoint Int Int

instance Show Rect where
    show (MkRect x y w h) = join [ "Rect "
                                 , show x
                                 , " "
                                 , show y
                                 , " "
                                 , show w
                                 , " "
                                 , show h
                                 ]


rectEmpty : Rect -> Bool
rectEmpty (MkRect x y w h) = w <= 0 || h <= 0


rectEquals : Rect -> Rect -> Bool
rectEquals (MkRect x1 y1 w1 h1) (MkRect x2 y2 w2 h2) =
    (x1 == x2) && (y1 == y2) && (w1 == w2) && (h1 == h2)


