module Main

import SDL.Common
import SDL.SDL
import SDL.Timer
import SDL.Rect
import SDL.Video
import SDL.Mouse
import SDL.Clipboard
import SDL.Events
import SDL.BlendMode
import SDL.CPUInfo
import SDL.Bits
import SDL.GameController



doInit : IO ()
doInit = do
    init <- Init [InitEverything]
    putStrLn $ show init

main : IO ()
main = do
    --drivers <- GetNumVideoDrivers
    --driver <- GetCurrentVideoDriver
    doInit
    i <- GetInit
    putStrLn $ show i
    CreateWindow "test" 600 600 600 600 [WindowShown]
    SetClipboardText "clipboard2"
    clip <- GetClipboardText
    putStrLn $ "Clipboard: " ++ (show clip)
    Delay 1000
    num <- GetDisplayBounds 0
    mode <- GetDisplayMode 0 0
    putStrLn $ show num
    putStrLn $ show mode