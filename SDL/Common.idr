module SDL.Common
--fixme -- put non sdl functions elsewhere
import SDL.Error
import Data.Bits

%lib C "SDL2"

%include C "SDL2/SDL.h"

%access public
--%default total

instance (Show a, Show b) => Show (Either a b) where
   show (Left l) = "Left " ++ (show l)
   show (Right r) = "Right " ++ (show r)

class Flag n a where
    toFlag : a -> n

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
    pows = map (pow 2) [0..32]

bitMaskToFlags : (Enumerable a, Flag Bits32 a) => Bits32 -> List a
bitMaskToFlags mask' =
    Prelude.List.catMaybes $ map read (decomposeBitMask mask')

fromSDLBool : Int -> Bool
fromSDLBool 0 = False
fromSDLBool _ = True

toSDLBool : Bool -> Int
toSDLBool True = 1
toSDLBool False = 0

getError : IO String
getError = do
    errorString <- GetError
    if (errorString == "")
      then return "<unknown error>"
      else return errorString

--fixme - probably no one will check this -- how to solve?
--wraps IO actions which can fail
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

--fixme rename
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

infixr 6 /**/
(/**/) : a -> b -> c -> (a, b, c)
(/**/) x y z = (x, y, z)

infixr 6 /*/
(/*/) : a -> b -> (a, b)
(/*/) x y = (x, y)

join : List String -> String
join [] = ""
join (x::xs) = foldr (++) "" xs
