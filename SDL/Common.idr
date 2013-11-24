module SDL.Common

import SDL.Error

%lib C "SDL2"

%include C "SDL2/SDL.h"
%include C "SDL2/SDL_rect.h"
%include C "SDL2/SDL_video.h"

total
or32 : Bits32 -> Bits32 -> Bits32
or32 a b = a `prim__orB32` b

class Flag n a where
    toFlag : a -> n

class Readable rep val where
    read : rep -> Maybe val

total
fromSDLBool : Int -> Bool
fromSDLBool 0 = False
fromSDLBool _ = True

total
toSDLBool : Bool -> Int
toSDLBool True = 1
toSDLBool False = 0

getError : IO String
getError = do
    errorString <- GetError
    if (errorString == "")
      then return "<unknown>"
      else return errorString

-- wraps IO actions which can fail
trySDL : IO Int -> IO (Maybe String)
trySDL action = do
    success <- action
    if (success /= 0)
      then do
        errorString <- getError
        return $ Just errorString
      else do
        return Nothing

trySDLRes : IO Int -> IO a -> IO (Either String a)
trySDLRes try' getter = do
    success <- fromSDLBool `map` try'
    if (not success)
      then do
        errorString <- GetError
        return $ Left errorString
      else do
        res <- getter
        return $ Right res


(<**->) : a -> a -> a -> (a, a, a)
(<**->) x y z = (x, y, z)

(<*->) : a -> a -> (a, a)
(<*->) x y = (x, y)
