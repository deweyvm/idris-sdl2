module Main

import Graphics.SDL.Common
import Graphics.SDL.SDL
import Graphics.SDL.Timer
import Graphics.SDL.Rect
import Graphics.SDL.Video
import Graphics.SDL.Mouse
import Graphics.SDL.Clipboard
import Graphics.SDL.Events
import Graphics.SDL.BlendMode
import Graphics.SDL.CPUInfo
import Graphics.SDL.Bits
import Graphics.SDL.GameController
import Graphics.SDL.Render

doInit : IO ()
doInit = do
    init <- Init [InitEverything]
    case init of
        Just err => putStrLn err
        Nothing => return ()

testRenderer : Renderer -> IO ()
testRenderer renderer = do
    info <- GetRenderDriverInfo renderer
    case info of
        Right (mkRendererInfo name flags formats maxwidth maxheight) =>
            putStrLn $ join [ name
                            , " "
                            , show flags
                            , " "
                            , show formats
                            , " "
                            , show maxwidth
                            , " "
                            , show maxheight
                            ]
        Left err => putStrLn ("ERROR " ++ err)

doWindow : IO ()
doWindow = do
    x <- CreateWindow "test" 600 600 600 600 [WindowShown]
    case x of
        Left err =>
            putStr "no window"
        Right win => do
            putStrLn "what"
            rend <- CreateRenderer win 0 [RendererAccelerated]
            testRenderer rend
            RenderClear rend
            SetRenderDrawColor rend red
            RenderDrawLine rend (mkPoint 0 0) (mkPoint 100 100)
            RenderPresent rend

eventLoopTest : IO ()
eventLoopTest = do
    event <- PollEvent
    case event of
        Left err => do
            Delay 10
            eventLoopTest
        Right (timestamp, event) =>
            case event of
                QuitEvent =>
                    return()
                a =>
                    eventLoopTest


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
