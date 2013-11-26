module SDL.Common

import SDL.Error
import Data.Bits

%lib C "SDL2"

%include C "SDL2/SDL.h"
%include C "SDL2/SDL_rect.h"
%include C "SDL2/SDL_video.h"

%access public

instance (Show a, Show b) => Show (Either a b) where
   show (Left l) = "Left " ++ (show l)
   show (Right r) = "Right " ++ (show r)

class Flag n a where
    toFlag : a -> n

total
sumBits : (Flag Bits32 a) => List a -> Bits32
sumBits flags = foldl prim__orB32 0x0 (map toFlag flags)

class Enumerable a where
    enumerate : List a

read : (Eq a, Enumerable e, Flag a e) => a -> Maybe e
read i = find (\x => toFlag x == i) enumerate


decomposeBitMask : Bits32 -> List Bits32
decomposeBitMask bits =
    (map (prim__andB32 bits) pows) where
    pows : List Bits32
    pows = map (pow 2) [0x00,0x01,0x02,0x03,0x04,0x05,0x06,0x07,0x08,0x09,0x0A,0x0B,0x0C,0x0D,0x0E,0x0F,0x10,0x11,0x12,0x13,0x14,0x15,0x16,0x17,0x18,0x19,0x1A,0x1B,0x1C,0x1D,0x1E,0x1F]


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
--fixme rename
trySDL : IO Int -> IO (Maybe String)
trySDL action = do
    success <- [| fromSDLBool action |]
    if (not success)
      then do
        errorString <- getError
        return $ Just errorString
      else do
        return Nothing

--fixme rename --> getOrElse and flip arguments
trySDLRes : IO Int -> IO a -> IO (Either String a)
trySDLRes try' getter = do
    success <- [| fromSDLBool try' |]
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