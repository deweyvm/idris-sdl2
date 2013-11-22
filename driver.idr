module Main

import SDL.Common
import SDL.SDL
import SDL.Timer
import SDL.Rect
import SDL.Video
import SDL.Mouse
import SDL.Clipboard

join' : (Show a, Show b) => Either String a -> Either String b -> String
join' (Left s) (Left r) = s ++ r
join' (Right s) (Left r) = (show s) ++ r
join' (Right s) (Right r) = (show s) ++ (show r)
join' (Left s) (Right r) = s ++ (show r)

instance (Show a, Show b) => Show (Either a b) where
   show (Left l) = "Left " ++ (show l)
   show (Right r) = "Right " ++ (show r)

doInit : IO ()
doInit = do
    init <- Init 7231
    putStrLn $ show init

printFormat : Either String Window -> IO ()
printFormat (Left err) = return ()
printFormat (Right win) = do
    fmt <- GetWindowPixelFormat win
    putStrLn $ show fmt

makeWindow : IO ()
makeWindow = do
  made <- CreateWindow "test" 600 600 600 11600 0x00000004
  printFormat made
  putStrLn $ show made
  
main : IO ()
main = do
    --drivers <- GetNumVideoDrivers
    --driver <- GetCurrentVideoDriver
    doInit
    makeWindow
    --window <- HackCreateWindow
    --clip <- GetClipboardText
    --putStrLn $ show clip
    Delay 1000
    num <- GetDisplayBounds 0
    mode <- GetDisplayMode 0 0
    putStrLn $ join' num mode