module SDL.GameController

import SDL.Common

%include C "SDL2/SDL_gamecontroller.h"
%include C "SDL/idris_SDL_gamecontroller.h"
%link C "idris_SDL_gamecontroller.o"

data JoystickGUID = mkJoystickGUID Bits16x8
data Joystick = mkJoystick Ptr
data GameController = mkGameController Ptr

public
GameControllerAddMapping : IO (Maybe String)
GameControllerAddMapping = do
    trySDL (mkForeign (FFun "SDL_GameControllerAddMapping" [] FInt))

freeSharedString : IO ()
freeSharedString = mkForeign (FFun "idris_gameController_sharedString_free" [] FUnit)


public
GameControllerMappingForGUID : JoystickGUID -> IO (Either String String)
GameControllerMappingForGUID (mkJoystickGUID bits) = do
    trySDLRes
        (mkForeign (FFun "idris_SDL_gameControllerMappingForGUID" [FBits16x8] FInt) bits)
        (mkForeign (FFun "idris_gameController_sharedString_string" [] FString) <$ freeSharedString)

public
GameControllerMapping : GameController -> IO (Either String String)
GameControllerMapping (mkGameController ptr) = do
    trySDLRes
        (mkForeign (FFun "idris_SDL_gameControllerMapping" [FPtr] FInt) ptr)
        (mkForeign (FFun "idris_gameController_sharedString_string" [] FString) <$ freeSharedString)

public
IsGameController : Int -> IO Bool
IsGameController id = do
    [| fromSDLBool (mkForeign (FFun "SDL_IsGameController" [FInt] FInt) id) |]

public
GameControllerNameForIndex : Int -> IO (Either String String)
GameControllerNameForIndex id = do
    trySDLRes
        (mkForeign (FFun "idris_SDL_gameControllerNameForIndex" [FInt] FInt) id)
        (mkForeign (FFun "idris_gameController_sharedString_string" [] FString) <$ freeSharedString)

public
GameControllerOpen : Int -> IO (Either String GameController)
GameControllerOpen id = do
    trySDLRes
        (mkForeign (FFun "idris_SDL_gameControllerOpen" [FInt] FInt) id)
        (mkGameController `map` (mkForeign (FFun "idris_sharedGameController_controller" [] FPtr)))

-- pure?
public
GameControllerName : GameController -> IO String
GameControllerName (mkGameController ptr) =
    mkForeign (FFun "SDL_GameControllerName" [FPtr] FString) ptr

public
GameControllerGetAttached : GameController -> IO Bool
GameControllerGetAttached (mkGameController ptr) = do
    [| fromSDLBool (mkForeign (FFun "SDL_GameControllerGetAttached" [FPtr] FInt) ptr) |]

public
GameControllerGetJoystick : GameController -> IO Joystick
GameControllerGetJoystick (mkGameController ptr) = do
    [| mkJoystick (mkForeign (FFun "SDL_GameControllerGetJoystick" [FPtr] FPtr) ptr) |]

--skipped because semantics are confusing
--public
--GameControllerEventState :
--GameControllerEventState
--extern DECLSPEC int SDLCALL SDL_GameControllerEventState(int state);

public
GameControllerUpdate : IO ()
GameControllerUpdate = mkForeign (FFun "SDL_GameControllerUpdate" [] FUnit)

data GameControllerAxis = ControllerAxisInvalid
                        | ControllerAxisLeftX
                        | ControllerAxisLeftY
                        | ControllerAxisRightX
                        | ControllerAxisRightY
                        | ControllerAxisTriggerLeft
                        | ControllerAxisTriggerRight
                        | ControllerAxisMax

instance Flag Int GameControllerAxis where
    toFlag ControllerAxisLeftX        =  0
    toFlag ControllerAxisLeftY        =  1
    toFlag ControllerAxisRightX       =  2
    toFlag ControllerAxisRightY       =  3
    toFlag ControllerAxisTriggerLeft  =  4
    toFlag ControllerAxisTriggerRight =  5
    toFlag ControllerAxisMax          =  6

GetAxes : List GameControllerAxis
GetAxes = [ControllerAxisInvalid, ControllerAxisLeftX, ControllerAxisLeftY, ControllerAxisRightX, ControllerAxisRightY, ControllerAxisTriggerLeft, ControllerAxisTriggerRight, ControllerAxisMax]

instance Readable Int GameControllerAxis where
    read i = find (\x => toFlag x == i) GetAxes

public
GameControllerGetAxisFromString : String -> IO (Maybe GameControllerAxis)
GameControllerGetAxisFromString str = do
    retval <- mkForeign (FFun "SDL_GameControllerGetAxisFromString" [FString] FInt) str
    return $ read retval

public
GameControllerGetStringForAxis : GameControllerAxis -> IO String
GameControllerGetStringForAxis axis =
    mkForeign (FFun "SDL_GameControllerGetStringForAxis" [FInt] FString) (toFlag axis)
