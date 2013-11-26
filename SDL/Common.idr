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

total
sumBits : (Flag Bits32 a) => List a -> Bits32
sumBits flags = foldl prim__orB32 0x0 (map toFlag flags)

class Enumerable a where
    enumerate : List a

read : (Eq a, Enumerable e, Flag a e) => a -> Maybe e
read i = find (\x => toFlag x == i) enumerate

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

--fixme - probably no one will check this -- how to solve?
-- wraps IO actions which can fail
trySDL : IO Int -> IO (Maybe String)
trySDL action = do
    success <- fromSDLBool `map` action
    if (not success)
      then do
        errorString <- getError
        return $ Just errorString
      else do
        return Nothing

--fixme rename
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

infixl 6 <**->
(<**->) : a -> a -> a -> (a, a, a)
(<**->) x y z = (x, y, z)

infixl 6 <*->
(<*->) : a -> a -> (a, a)
(<*->) x y = (x, y)

join : List String -> String
join [] = ""
join (x::xs) = foldr (++) "" xs