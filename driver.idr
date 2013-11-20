module Main

import SDL.Common
import SDL.SDL
import SDL.Rect
import SDL.Video
--- %include C "idris_SDL_video.h"
--- %link C "idris_SDL_video.c"
--- %lib C "SDL2"

{-SDL_Init : () -> IO String
SDL_Init i = mkForeign (FFun "mySDL_Init" [FUnit] FString) i

SDL_Quit : () -> IO ()
SDL_Quit x = mkForeign (FFun "mySDL_Quit" [FUnit] FUnit) x

SDL_GetPlatform : () -> IO String
SDL_GetPlatform x = mkForeign (FFun "mySDL_GetPlatform" [FUnit] FString) x

SDL_Window : Type
SDL_Window = Ptr

SDL_CreateWindow : () -> IO SDL_Window
SDL_CreateWindow x = mkForeign (FFun "mySDL_CreateWindow" [FUnit] FPtr) x

SDL_SetWindowPosition : SDL_Window -> Int -> Int -> IO ()
SDL_SetWindowPosition window x y = mkForeign (FFun "mySDL_SetWindowPosition" [FPtr, FInt, FInt] FUnit) window x y

SDL_Delay : Int -> IO ()
SDL_Delay t = mkForeign (FFun "mySDL_Delay" [FInt] FUnit) t
-}

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
    {-case num of
      Left err => putStrLn err
      Right rect => putStrLn $ show rect
    mode <- GetDisplayMode 0 0
    case mode of
      Left err => putStrLn err
      Right m => putStrLn $ show m-}
    --putStrLn $ show init
    
    --putStrLn $ show drivers
    --putStrLn $ show $ mkRect 1 2 3 4