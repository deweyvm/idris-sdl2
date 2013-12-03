module Graphics.SDL.Common
--fixme -- put non sdl functions elsewhere
import Graphics.SDL.Error
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

class Enumerable a where
    enumerate : List a

sumBits : (Flag Bits32 a) => List a -> Bits32
sumBits flags = foldl prim__orB32 0x0 (map toFlag flags)

read : (Eq a, Enumerable e, Flag a e) => a -> Maybe e
read i = List.find (\x => toFlag x == i) enumerate

readOrElse : (Eq a, Enumerable e, Flag a e) => e -> a -> e
readOrElse def x = case read x of
    Just x => x
    Nothing => def

private
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
doSDL : IO Int -> IO (Maybe String)
doSDL action = do
    success <- [| fromSDLBool action |]
    if (not success)
      then do
        errorString <- getError
        return $ Just errorString
      else do
        return Nothing

doSDLMaybe : IO Int -> IO a -> IO (Maybe a)
doSDLMaybe try' getter = do
    success <- [| fromSDLBool try' |]
    if (not success)
      then return Nothing
      else do
        res <- getter
        return $ Just res

--wraps IO actions which return an action, but may fail
--first arg is the int status return value of many SDL library functions.
--we expect 1 to mean success, but many SDL functions return 0 instead. this
--must be taken care of in the wrapper library.
doSDLIf : IO Int -> IO a -> IO (Either String a)
doSDLIf try' getter = do
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
