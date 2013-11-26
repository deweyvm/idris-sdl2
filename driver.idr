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

instance (Show a, Show b) => Show (Either a b) where
   show (Left l) = "Left " ++ (show l)
   show (Right r) = "Right " ++ (show r)

doInit : IO ()
doInit = do
    init <- Init [InitEverything]
    putStrLn $ show init

printFormat : Either String Window -> IO ()
printFormat (Left err) = return ()
printFormat (Right win) = do
    fmt <- GetWindowPixelFormat win
    putStrLn $ show fmt

--makeWindow : IO ()
--makeWindow = do
--  made <- CreateWindow "test" 600 600 600 600 [WindowShown]
--  printFormat made
--  putStrLn $ show made

main : IO ()
main = do
    --drivers <- GetNumVideoDrivers
    --driver <- GetCurrentVideoDriver
    doInit
    CreateWindow "test" 600 600 600 600 [WindowShown]
    SetClipboardText "clipboard2"
    clip <- GetClipboardText
    putStrLn $ "Clipboard: " ++ (show clip)
    Delay 1000
    num <- GetDisplayBounds 0
    mode <- GetDisplayMode 0 0
    putStrLn $ show num
    putStrLn $ show mode