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
import SDL.Render

doInit : IO ()
doInit = do
    init <- Init [InitEverything]
    putStrLn $ show init

doWindow : IO ()
doWindow = do
    x <- CreateWindow "test" 600 600 600 600 [WindowShown]
    case x of
        Left err => return ()
        Right win => do
            rend <- CreateRenderer win 0 [RendererAccelerated]
            RenderClear rend
            SetRenderDrawColor rend red
            RenderDrawLine rend 0 0 100 100
            RenderPresent rend
main : IO ()
main = do
    --drivers <- GetNumVideoDrivers
    --driver <- GetCurrentVideoDriver
    doInit
    i <- GetInit
    putStrLn $ show i
    doWindow
    SetClipboardText "clipboard2"
    clip <- GetClipboardText
    putStrLn $ "Clipboard: " ++ (show clip)
    Delay 1000
    num <- GetDisplayBounds 0
    mode <- GetDisplayMode 0 0
    putStrLn $ show num
    putStrLn $ show mode
