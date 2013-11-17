module Main

import SDL.Common
import SDL.Rect

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
main : IO ()
main = do
    putStrLn $ show $ mkRect 1 2 3 4