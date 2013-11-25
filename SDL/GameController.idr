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

instance Enumerable GameControllerAxis where
    enumerate = [ControllerAxisInvalid, ControllerAxisLeftX, ControllerAxisLeftY, ControllerAxisRightX, ControllerAxisRightY, ControllerAxisTriggerLeft, ControllerAxisTriggerRight, ControllerAxisMax]

public
GameControllerGetAxisFromString : String -> IO (Maybe GameControllerAxis)
GameControllerGetAxisFromString str = do
    retval <- mkForeign (FFun "SDL_GameControllerGetAxisFromString" [FString] FInt) str
    return $ read retval

public
GameControllerGetStringForAxis : GameControllerAxis -> IO String
GameControllerGetStringForAxis axis =
    mkForeign (FFun "SDL_GameControllerGetStringForAxis" [FInt] FString) (toFlag axis)

--skipped: not sure how this struct is used
--extern DECLSPEC SDL_GameControllerButtonBind SDLCALL
--SDL_GameControllerGetBindForAxis(SDL_GameController *gamecontroller,
--                                 SDL_GameControllerAxis axis);
public
GameControllerGetAxis : GameController -> GameControllerAxis -> IO Int
GameControllerGetAxis (mkGameController ptr) axis = do
    mkForeign (FFun "SDL_GameControllerGetAxis" [FPtr, FInt] FInt) ptr (toFlag axis)

data GameControllerButton = ControllerButtonA
                          | ControllerButtonB
                          | ControllerButtonX
                          | ControllerButtonY
                          | ControllerButtonBack
                          | ControllerButtonGuide
                          | ControllerButtonStart
                          | ControllerButtonLeftStick
                          | ControllerButtonRightStick
                          | ControllerButtonLeftShoulder
                          | ControllerButtonRightShoulder
                          | ControllerButtonDpadUp
                          | ControllerButtonDpadDown
                          | ControllerButtonDpadLeft
                          | ControllerButtonDpadRight
                          | ControllerButtonMax

instance Flag Int GameControllerButton where
    toFlag ControllerButtonA             = 0
    toFlag ControllerButtonB             = 1
    toFlag ControllerButtonX             = 2
    toFlag ControllerButtonY             = 3
    toFlag ControllerButtonBack          = 4
    toFlag ControllerButtonGuide         = 5
    toFlag ControllerButtonStart         = 6
    toFlag ControllerButtonLeftStick     = 7
    toFlag ControllerButtonRightStick    = 8
    toFlag ControllerButtonLeftShoulder  = 9
    toFlag ControllerButtonRightShoulder = 10
    toFlag ControllerButtonDpadUp        = 11
    toFlag ControllerButtonDpadDown      = 12
    toFlag ControllerButtonDpadLeft      = 13
    toFlag ControllerButtonDpadRight     = 14
    toFlag ControllerButtonMax           = 15

instance Enumerable GameControllerButton where
    enumerate = [ControllerButtonA, ControllerButtonB, ControllerButtonX, ControllerButtonY, ControllerButtonBack, ControllerButtonGuide, ControllerButtonStart, ControllerButtonLeftStick, ControllerButtonRightStick, ControllerButtonLeftShoulder, ControllerButtonRightShoulder, ControllerButtonDpadUp, ControllerButtonDpadDown, ControllerButtonDpadLeft, ControllerButtonDpadRight, ControllerButtonMax]

public
GameControllerGetButtonFromString : String -> IO (Maybe GameControllerButton)
GameControllerGetButtonFromString str = do
    retval <- mkForeign (FFun "SDL_GameControllerGetButtonFromString" [FString] FInt) str
    return $ read retval

public
GameControllerGetStringForButton : GameControllerButton -> IO String
GameControllerGetStringForButton b =
    mkForeign (FFun "SDL_GameControllerGetStringForButton" [FInt] FString) (toFlag b)

--skipped: not sure how this struct is used
--extern DECLSPEC SDL_GameControllerButtonBind SDLCALL
--SDL_GameControllerGetBindForButton(SDL_GameController *gamecontroller,
--                                   SDL_GameControllerButton button);

GameControllerGetButton : GameController -> GameControllerButton -> IO Int
GameControllerGetButton (mkGameController ptr) c =
    mkForeign (FFun "SDL_GameControllerGetButton" [FPtr, FInt] FInt) ptr (toFlag c)

GameControllerClose : GameController -> IO ()
GameControllerClose (mkGameController ptr) =
    mkForeign (FFun "SDL_GameControllerClose" [FPtr] FUnit) ptr
