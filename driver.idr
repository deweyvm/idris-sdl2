module Main

import SDL.Common
import SDL.SDL
import SDL.Rect
import SDL.Video
import SDL.Mouse

join' : (Show a, Show b) => Either String a -> Either String b -> String
join' (Left s) (Left r) = s ++ r
join' (Right s) (Left r) = (show s) ++ r
join' (Right s) (Right r) = (show s) ++ (show r)
join' (Left s) (Right r) = s ++ (show r)

main : IO ()
main = do
    --drivers <- GetNumVideoDrivers
    --driver <- GetCurrentVideoDriver
    init <- Init 32
    num <- GetDisplayBounds 0
    mode <- GetDisplayMode 0 0
    putStrLn $ join' num mode