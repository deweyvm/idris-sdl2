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
import Utils.Map

doInit : IO ()
doInit = do
    init <- init [InitEverything]
    case init of
        Just err => putStrLn err
        Nothing => return ()

testRenderer : Renderer -> IO ()
testRenderer renderer = do
    info <- getRenderDriverInfo renderer
    case info of
        Right (MkRendererInfo name flags formats maxwidth maxheight) =>
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
    x <- createWindow "test" 600 600 600 600 [WindowShown]
    case x of
        Left err =>
            putStr "no window"
        Right win => do
            putStrLn "what"
            rend <- createRenderer win 0 [RendererAccelerated]
            testRenderer rend
            renderClear rend
            setRenderDrawColor rend red
            renderDrawLine rend (MkPoint 0 0) (MkPoint 100 100)
            renderPresent rend

eventLoopTest : IO ()
eventLoopTest = do
    event <- pollEvent
    case event of
        Left err => do
            delay 10
            eventLoopTest
        Right (timestamp, event) =>
            case event of
                QuitEvent =>
                    return()
                a =>
                    eventLoopTest


main : IO ()
main = do
    doInit
    i <- getInit
    putStrLn $ show i
    doWindow
    setClipboardText "clipboard2"
    clip <- getClipboardText
    putStrLn $ "Clipboard: " ++ (show clip)
    delay 1000

    num <- getDisplayBounds 0
    mode <- getDisplayMode 0 0
    putStrLn $ show num
    putStrLn $ show mode
