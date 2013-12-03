module Graphics.SDL.GameController

import Graphics.SDL.Common

%include C "SDL2/SDL_gamecontroller.h"
%include C "csrc/idris_SDL_gamecontroller.h"
%link C "idris_SDL_gamecontroller.o"

data JoystickGUID = MkJoystickGUID Bits16x8
data Joystick = MkJoystick Ptr
data GameController = MkGameController Ptr

public
gameControllerAddMapping : IO (Maybe String)
gameControllerAddMapping = do
    doSDL (mkForeign (FFun "SDL_GameControllerAddMapping" [] FInt))

freeSharedString : IO ()
freeSharedString = mkForeign (FFun "idris_gameController_sharedString_free" [] FUnit)


public
gameControllerMappingForGUID : JoystickGUID -> IO (Either String String)
gameControllerMappingForGUID (MkJoystickGUID bits) = do
    doSDLIf
        (mkForeign (FFun "idris_SDL_gameControllerMappingForGUID" [FBits16x8] FInt) bits)
        (mkForeign (FFun "idris_gameController_sharedString_string" [] FString)
            <$ freeSharedString)

public
gameControllerMapping : GameController -> IO (Either String String)
gameControllerMapping (MkGameController ptr) = do
    doSDLIf
        (mkForeign (FFun "idris_SDL_gameControllerMapping" [FPtr] FInt) ptr)
        (mkForeign (FFun "idris_gameController_sharedString_string" [] FString)
            <$ freeSharedString)

public
isGameController : Int -> IO Bool
isGameController id = do
    [| fromSDLBool (mkForeign (FFun "SDL_IsGameController" [FInt] FInt) id) |]

public
gameControllerNameForIndex : Int -> IO (Either String String)
gameControllerNameForIndex id = do
    doSDLIf
        (mkForeign (FFun "idris_SDL_gameControllerNameForIndex" [FInt] FInt) id)
        (mkForeign (FFun "idris_gameController_sharedString_string" [] FString)
            <$ freeSharedString)

public
gameControllerOpen : Int -> IO (Either String GameController)
gameControllerOpen id = do
    doSDLIf
        (mkForeign (FFun "idris_SDL_gameControllerOpen" [FInt] FInt) id)
        [| MkGameController (mkForeign (FFun "idris_sharedGameController_controller" [] FPtr)) |]

public
gameControllerName : GameController -> IO String
gameControllerName (MkGameController ptr) =
    mkForeign (FFun "SDL_GameControllerName" [FPtr] FString) ptr

public
gameControllerGetAttached : GameController -> IO Bool
gameControllerGetAttached (MkGameController ptr) = do
    [| fromSDLBool (mkForeign (FFun "SDL_GameControllerGetAttached" [FPtr] FInt) ptr) |]

public
gameControllerGetJoystick : GameController -> IO Joystick
gameControllerGetJoystick (MkGameController ptr) = do
    [| MkJoystick (mkForeign (FFun "SDL_GameControllerGetJoystick" [FPtr] FPtr) ptr) |]

--skipped because semantics are confusing
--public
--GameControllerEventState :
--GameControllerEventState
--extern DECLSPEC int SDLCALL SDL_GameControllerEventState(int state);

public
gameControllerUpdate : IO ()
gameControllerUpdate = mkForeign (FFun "SDL_GameControllerUpdate" [] FUnit)

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
gameControllerGetAxisFromString : String -> IO (Maybe GameControllerAxis)
gameControllerGetAxisFromString str =
    [| read (mkForeign (FFun "SDL_GameControllerGetAxisFromString" [FString] FInt) str) |]

public
gameControllerGetStringForAxis : GameControllerAxis -> IO String
gameControllerGetStringForAxis axis =
    mkForeign (FFun "SDL_GameControllerGetStringForAxis" [FInt] FString) (toFlag axis)

--skipped: not sure how this struct is used
--extern DECLSPEC SDL_GameControllerButtonBind SDLCALL
--SDL_GameControllerGetBindForAxis(SDL_GameController *gamecontroller,
--                                 SDL_GameControllerAxis axis);
public
gameControllerGetAxis : GameController -> GameControllerAxis -> IO Int
gameControllerGetAxis (MkGameController ptr) axis =
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

instance Enumerable GameControllerButton where
    enumerate = [ControllerButtonA, ControllerButtonB, ControllerButtonX, ControllerButtonY, ControllerButtonBack, ControllerButtonGuide, ControllerButtonStart, ControllerButtonLeftStick, ControllerButtonRightStick, ControllerButtonLeftShoulder, ControllerButtonRightShoulder, ControllerButtonDpadUp, ControllerButtonDpadDown, ControllerButtonDpadLeft, ControllerButtonDpadRight]

public
gameControllerGetButtonFromString : String -> IO (Maybe GameControllerButton)
gameControllerGetButtonFromString str = do
    [| read (mkForeign (FFun "SDL_GameControllerGetButtonFromString" [FString] FInt) str) |]

public
gameControllerGetStringForButton : GameControllerButton -> IO String
gameControllerGetStringForButton b =
    mkForeign (FFun "SDL_GameControllerGetStringForButton" [FInt] FString) (toFlag b)

--skipped: not sure how this struct is used
--extern DECLSPEC SDL_GameControllerButtonBind SDLCALL
--SDL_GameControllerGetBindForButton(SDL_GameController *gamecontroller,
--                                   SDL_GameControllerButton button);

gameControllerGetButton : GameController -> GameControllerButton -> IO Int
gameControllerGetButton (MkGameController ptr) c =
    mkForeign (FFun "SDL_GameControllerGetButton" [FPtr, FInt] FInt) ptr (toFlag c)

gameControllerClose : GameController -> IO ()
gameControllerClose (MkGameController ptr) =
    mkForeign (FFun "SDL_GameControllerClose" [FPtr] FUnit) ptr
