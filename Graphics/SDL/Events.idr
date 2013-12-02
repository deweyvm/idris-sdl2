module Graphics.SDL.Events

import Graphics.SDL.Common
import Graphics.SDL.Keyboard

import Graphics.SDL.ScanCode
import Graphics.SDL.KeyCode

%include C "SDL2/SDL_events.h"
%include C "csrc/idris_SDL_events.h"
%link C "idris_SDL_events.o"

--OSEvent is missing because i dont see how you would get one, there is
-- no flag associated with it

data EventType = Quit
               | AppTerminating
               | AppLowMemory
               | AppWillEnterBackground
               | AppDidEnterBackground
               | AppWillEnterForeground
               | AppDidEnterForeground
               | Window
               | Syswm
               | KeyDown
               | KeyUp
               | TextEditing
               | TextInput
               | MouseMotion
               | MouseButtonDown
               | MouseButtonUp
               | MouseWheel
               | JoyAxisMotion
               | JoyBallMotion
               | JoyHatMotion
               | JoyButtonDown
               | JoyButtonUp
               | JoyDeviceAdded
               | JoyDeviceRemoved
               | ControllerAxisMotion
               | ControllerButtonDown
               | ControllerButtonUp
               | ControllerDeviceAdded
               | ControllerDeviceRemoved
               | ControllerDeviceRemapped
               | FingerDown
               | FingerUp
               | FingerMotion
               | DollarGesture
               | DollarRecord
               | MultiGesture
               | ClipboardUpdate
               | DropFile
               | User

instance Show EventType where
    show Quit                     = "Quit"
    show AppTerminating           = "AppTerminating"
    show AppLowMemory             = "AppLowMemory"
    show AppWillEnterBackground   = "AppWillEnterBackground"
    show AppDidEnterBackground    = "AppDidEnterBackground"
    show AppWillEnterForeground   = "AppWillEnterForeground"
    show AppDidEnterForeground    = "AppDidEnterForeground"
    show Window                   = "Window"
    show Syswm                    = "Syswm"
    show KeyDown                  = "KeyDown"
    show KeyUp                    = "KeyUp"
    show TextEditing              = "TextEditing"
    show TextInput                = "TextInput"
    show MouseMotion              = "MouseMotion"
    show MouseButtonDown          = "MouseButtonDown"
    show MouseButtonUp            = "MouseButtonUp"
    show MouseWheel               = "MouseWheel"
    show JoyAxisMotion            = "JoyAxisMotion"
    show JoyBallMotion            = "JoyBallMotion"
    show JoyHatMotion             = "JoyHatMotion"
    show JoyButtonDown            = "JoyButtonDown"
    show JoyButtonUp              = "JoyButtonUp"
    show JoyDeviceAdded           = "JoyDeviceAdded"
    show JoyDeviceRemoved         = "JoyDeviceRemoved"
    show ControllerAxisMotion     = "ControllerAxisMotion"
    show ControllerButtonDown     = "ControllerButtonDown"
    show ControllerButtonUp       = "ControllerButtonUp"
    show ControllerDeviceAdded    = "ControllerDeviceAdded"
    show ControllerDeviceRemoved  = "ControllerDeviceRemoved"
    show ControllerDeviceRemapped = "ControllerDeviceRemapped"
    show FingerDown               = "FingerDown"
    show FingerUp                 = "FingerUp"
    show FingerMotion             = "FingerMotion"
    show DollarGesture            = "DollarGesture"
    show DollarRecord             = "DollarRecord"
    show MultiGesture             = "MultiGesture"
    show ClipboardUpdate          = "ClipboardUpdate"
    show DropFile                 = "DropFile"
    show User                     = "User"

instance Flag Bits32 EventType where
    toFlag Quit                     = 0x100
    toFlag AppTerminating           = 0x101
    toFlag AppLowMemory             = 0x102
    toFlag AppWillEnterBackground   = 0x103
    toFlag AppDidEnterBackground    = 0x104
    toFlag AppWillEnterForeground   = 0x105
    toFlag AppDidEnterForeground    = 0x106
    toFlag Window                   = 0x200
    toFlag Syswm                    = 0x201
    toFlag KeyDown                  = 0x300
    toFlag KeyUp                    = 0x301
    toFlag TextEditing              = 0x302
    toFlag TextInput                = 0x303
    toFlag MouseMotion              = 0x400
    toFlag MouseButtonDown          = 0x401
    toFlag MouseButtonUp            = 0x402
    toFlag MouseWheel               = 0x403
    toFlag JoyAxisMotion            = 0x600
    toFlag JoyBallMotion            = 0x601
    toFlag JoyHatMotion             = 0x602
    toFlag JoyButtonDown            = 0x603
    toFlag JoyButtonUp              = 0x604
    toFlag JoyDeviceAdded           = 0x605
    toFlag JoyDeviceRemoved         = 0x606
    toFlag ControllerAxisMotion     = 0x650
    toFlag ControllerButtonDown     = 0x651
    toFlag ControllerButtonUp       = 0x652
    toFlag ControllerDeviceAdded    = 0x653
    toFlag ControllerDeviceRemoved  = 0x654
    toFlag ControllerDeviceRemapped = 0x655
    toFlag FingerDown               = 0x700
    toFlag FingerUp                 = 0x701
    toFlag FingerMotion             = 0x702
    toFlag DollarGesture            = 0x800
    toFlag DollarRecord             = 0x801
    toFlag MultiGesture             = 0x802
    toFlag ClipboardUpdate          = 0x900
    toFlag DropFile                 = 0x1000
    toFlag User                     = 0x8000

instance Enumerable EventType where
    enumerate = [Quit, AppTerminating, AppLowMemory, AppWillEnterBackground, AppDidEnterBackground, AppWillEnterForeground, AppDidEnterForeground, Window, Syswm, KeyDown, KeyUp, TextEditing, TextInput, MouseMotion, MouseButtonDown, MouseButtonUp, MouseWheel, JoyAxisMotion, JoyBallMotion, JoyHatMotion, JoyButtonDown, JoyButtonUp, JoyDeviceAdded, JoyDeviceRemoved, ControllerAxisMotion, ControllerButtonDown, ControllerButtonUp, ControllerDeviceAdded, ControllerDeviceRemoved, ControllerDeviceRemapped, FingerDown, FingerUp, FingerMotion, DollarGesture, DollarRecord, MultiGesture, ClipboardUpdate, DropFile, User]

public
data ButtonEventType = ButtonUp
                     | ButtonDown

public
data FingerEventType = FingerEventUp
                     | FingerEventDown
                     | FingerEventMotion

public
data GestureEventType = GestureRecord
                      | GestureGesture

public
data JoyDeviceEventType = JoyDeviceEventAdded
                        | JoyDeviceEventRemoved

public
data ControllerDeviceEventType = ControllerDeviceEventAdded
                               | ControllerDeviceEventRemoved
                               | ControllerDeviceEventRemapped

public
data Event = WindowEvent Bits32 Bits8 Bits8 Bits8 Bits8 Int Int
           | KeyboardEvent ButtonEventType Bits32 Bits8 Bits8 Bits8 Bits8 KeySym
           | TextEditingEvent Bits32 String Int Int
           | TextInputEvent Bits32 String
           | MouseMotionEvent Bits32 Bits32 Bits32 Int Int Int Int
           | MouseButtonEvent ButtonEventType Bits32 Bits32 Bits8 Bits8 Bits8 Bits8 Int Int
           | MouseWheelEvent Bits32 Bits32 Int Int
           | JoyAxisEvent Int Bits8 Bits8 Bits8 Bits8 Bits32 Bits16
           | JoyBallEvent Int Bits8 Bits8 Bits8 Bits8 Bits32 Bits32
           | JoyHatEvent Int Bits8 Bits8 Bits8 Bits8
           | JoyButtonEvent ButtonEventType Int Bits8 Bits8 Bits8 Bits8
           | JoyDeviceEvent JoyDeviceEventType Int
           | ControllerAxisEvent Int Bits8 Bits8 Bits8 Bits8 Bits32 Bits16
           | ControllerButtonEvent ButtonEventType Int Bits8 Bits8 Bits8 Bits8
           | ControllerDeviceEvent ControllerDeviceEventType Int
           | TouchFingerEvent FingerEventType Bits64 Bits64 Float Float Float Float Float
           | MultiGestureEvent Bits64 Float Float Float Float Bits16 Bits16
           | DollarGestureEvent GestureEventType Bits64 Bits64 Bits32 Float Float Float
           | DropEvent Ptr
           | QuitEvent
           | OSEvent
           | UserEvent Bits32 Int Ptr Ptr
           | SysWMEvent Ptr
           | UnknownEvent EventType
public
PumpEvents : IO ()
PumpEvents = mkForeign (FFun "SDL_PumpEvents" [] FUnit)

--int SDLCALL SDL_PeepEvents(SDL_Event * events, int numevents, SDL_eventaction action, Uint32 minType, Uint32 maxType);


HasEvent : EventType -> IO Bool
HasEvent t = do
    [| fromSDLBool (mkForeign (FFun "SDL_HasEvent" [FBits32] FInt) (toFlag t)) |]

--fixme: should use some generalized filterM here
findA : (Applicative f, Traversable ls) => (a -> f Bool) -> ls a -> f Bool
findA fun xs = (map (any id)) (sequence (map fun xs))

public
HasEvents : List EventType -> IO Bool
HasEvents xs = findA HasEvent xs

public
FlushEvent : EventType -> IO ()
FlushEvent t = mkForeign (FFun "SDL_FlushEvent" [FBits32] FUnit) (toFlag t)

public
FlushEvents : List EventType -> IO ()
FlushEvents xs = sequence_ (map FlushEvent xs)

{- | If the code is valid, return the corresponding EventType
     Otherwise, return the raw bit value -}
getEventType : IO (Either Bits32 EventType)
getEventType = do
    rawCode <- (mkForeign (FFun "idris_getEventType" [] FBits32))
    case read{e=EventType} rawCode of
        Nothing => return $ Left rawCode
        Just t => return $ Right t

getTimestamp : IO Bits32
getTimestamp = mkForeign (FFun "idris_getTimestamp" [] FBits32)


getWindowEvent_windowID : IO Bits32
getWindowEvent_windowID =
    mkForeign (FFun "idris_windowEvent_windowID" [] FBits32)
getWindowEvent_event : IO Bits8
getWindowEvent_event =
    mkForeign (FFun "idris_windowEvent_event" [] FBits8)
getWindowEvent_padding1 : IO Bits8
getWindowEvent_padding1 =
    mkForeign (FFun "idris_windowEvent_padding1" [] FBits8)
getWindowEvent_padding2 : IO Bits8
getWindowEvent_padding2 =
    mkForeign (FFun "idris_windowEvent_padding2" [] FBits8)
getWindowEvent_padding3 : IO Bits8
getWindowEvent_padding3 =
    mkForeign (FFun "idris_windowEvent_padding3" [] FBits8)
getWindowEvent_data1 : IO Int
getWindowEvent_data1 =
    mkForeign (FFun "idris_windowEvent_data1" [] FInt)
getWindowEvent_data2 : IO Int
getWindowEvent_data2 =
    mkForeign (FFun "idris_windowEvent_data2" [] FInt)

getWindowEvent : IO Event
getWindowEvent =
    [| WindowEvent getWindowEvent_windowID
                   getWindowEvent_event
                   getWindowEvent_padding1
                   getWindowEvent_padding2
                   getWindowEvent_padding3
                   getWindowEvent_data1
                   getWindowEvent_data2 |]


getKeyboardEvent_windowID : IO Bits32
getKeyboardEvent_windowID =
    mkForeign (FFun "idris_keyboardEvent_windowID" [] FBits32)
getKeyboardEvent_state : IO Bits8
getKeyboardEvent_state =
    mkForeign (FFun "idris_keyboardEvent_state" [] FBits8)
getKeyboardEvent_repeat : IO Bits8
getKeyboardEvent_repeat =
    mkForeign (FFun "idris_keyboardEvent_repeat" [] FBits8)
getKeyboardEvent_padding2 : IO Bits8
getKeyboardEvent_padding2 =
    mkForeign (FFun "idris_keyboardEvent_padding2" [] FBits8)
getKeyboardEvent_padding3 : IO Bits8
getKeyboardEvent_padding3 =
    mkForeign (FFun "idris_keyboardEvent_padding3" [] FBits8)


getKeyboardEvent_keysym_scancode : IO ScanCode
getKeyboardEvent_keysym_scancode =
    (readOrElse ScanCode.Unknown) `map` (mkForeign (FFun "idris_keyboardEvent_keysym_scancode" [] FBits32))

getKeyboardEvent_keysym_sym : IO KeyCode
getKeyboardEvent_keysym_sym =
    (readOrElse KeyCode.Unknown) `map` (mkForeign (FFun "idris_keyboardEvent_keysym_sym" [] FBits32))

getKeyboardEvent_keysym_mod : IO (List KeyMod)
getKeyboardEvent_keysym_mod =
    bitMaskToFlags `map` (mkForeign (FFun "idris_keyboardEvent_keysym_mod" [] FBits32))

getKeyboardEvent_keysym : IO KeySym
getKeyboardEvent_keysym =
    [| mkKeySym getKeyboardEvent_keysym_scancode
                getKeyboardEvent_keysym_sym
                getKeyboardEvent_keysym_mod |]



getKeyboardEvent : ButtonEventType -> IO Event
getKeyboardEvent button =
    [| KeyboardEvent (return button)
                     getKeyboardEvent_windowID
                     getKeyboardEvent_state
                     getKeyboardEvent_repeat
                     getKeyboardEvent_padding2
                     getKeyboardEvent_padding3
                     getKeyboardEvent_keysym |]


getTextEditingEvent_windowID : IO Bits32
getTextEditingEvent_windowID =
    mkForeign (FFun "idris_textEditingEvent_windowID" [] FBits32)
getTextEditingEvent_text : IO String
getTextEditingEvent_text =
    mkForeign (FFun "idris_textEditingEvent_text" [] FString)
getTextEditingEvent_start : IO Int
getTextEditingEvent_start =
    mkForeign (FFun "idris_textEditingEvent_start" [] FInt)
getTextEditingEvent_length : IO Int
getTextEditingEvent_length =
    mkForeign (FFun "idris_textEditingEvent_length" [] FInt)

getTextEditingEvent : IO Event
getTextEditingEvent =
    [| TextEditingEvent getTextEditingEvent_windowID
                        getTextEditingEvent_text
                        getTextEditingEvent_start
                        getTextEditingEvent_length |]


getTextInputEvent_windowID : IO Bits32
getTextInputEvent_windowID =
    mkForeign (FFun "idris_textInputEvent_windowID" [] FBits32)
getTextInputEvent_text : IO String
getTextInputEvent_text =
    mkForeign (FFun "idris_textInputEvent_text" [] FString)

getTextInputEvent : IO Event
getTextInputEvent =
    [| TextInputEvent getTextInputEvent_windowID
                      getTextInputEvent_text |]


getMouseMotionEvent_windowID : IO Bits32
getMouseMotionEvent_windowID =
    mkForeign (FFun "idris_mouseMotionEvent_windowID" [] FBits32)
getMouseMotionEvent_which : IO Bits32
getMouseMotionEvent_which =
    mkForeign (FFun "idris_mouseMotionEvent_which" [] FBits32)
getMouseMotionEvent_state : IO Bits32
getMouseMotionEvent_state =
    mkForeign (FFun "idris_mouseMotionEvent_state" [] FBits32)
getMouseMotionEvent_x : IO Int
getMouseMotionEvent_x =
    mkForeign (FFun "idris_mouseMotionEvent_x" [] FInt)
getMouseMotionEvent_y : IO Int
getMouseMotionEvent_y =
    mkForeign (FFun "idris_mouseMotionEvent_y" [] FInt)
getMouseMotionEvent_xrel : IO Int
getMouseMotionEvent_xrel =
    mkForeign (FFun "idris_mouseMotionEvent_xrel" [] FInt)
getMouseMotionEvent_yrel : IO Int
getMouseMotionEvent_yrel =
    mkForeign (FFun "idris_mouseMotionEvent_yrel" [] FInt)

getMouseMotionEvent : IO Event
getMouseMotionEvent =
    [| MouseMotionEvent getMouseMotionEvent_windowID
                        getMouseMotionEvent_which
                        getMouseMotionEvent_state
                        getMouseMotionEvent_x
                        getMouseMotionEvent_y
                        getMouseMotionEvent_xrel
                        getMouseMotionEvent_yrel |]


getMouseButtonEvent_windowID : IO Bits32
getMouseButtonEvent_windowID =
    mkForeign (FFun "idris_mouseButtonEvent_windowID" [] FBits32)
getMouseButtonEvent_which : IO Bits32
getMouseButtonEvent_which =
    mkForeign (FFun "idris_mouseButtonEvent_which" [] FBits32)
getMouseButtonEvent_button : IO Bits8
getMouseButtonEvent_button =
    mkForeign (FFun "idris_mouseButtonEvent_button" [] FBits8)
getMouseButtonEvent_state : IO Bits8
getMouseButtonEvent_state =
    mkForeign (FFun "idris_mouseButtonEvent_state" [] FBits8)
getMouseButtonEvent_padding1 : IO Bits8
getMouseButtonEvent_padding1 =
    mkForeign (FFun "idris_mouseButtonEvent_padding1" [] FBits8)
getMouseButtonEvent_padding2 : IO Bits8
getMouseButtonEvent_padding2 =
    mkForeign (FFun "idris_mouseButtonEvent_padding2" [] FBits8)
getMouseButtonEvent_x : IO Int
getMouseButtonEvent_x =
    mkForeign (FFun "idris_mouseButtonEvent_x" [] FInt)
getMouseButtonEvent_y : IO Int
getMouseButtonEvent_y =
    mkForeign (FFun "idris_mouseButtonEvent_y" [] FInt)

getMouseButtonEvent : ButtonEventType -> IO Event
getMouseButtonEvent button =
    [| MouseButtonEvent (return button)
                        getMouseButtonEvent_windowID
                        getMouseButtonEvent_which
                        getMouseButtonEvent_button
                        getMouseButtonEvent_state
                        getMouseButtonEvent_padding1
                        getMouseButtonEvent_padding2
                        getMouseButtonEvent_x
                        getMouseButtonEvent_y |]


getMouseWheelEvent_windowID : IO Bits32
getMouseWheelEvent_windowID =
    mkForeign (FFun "idris_mouseWheelEvent_windowID" [] FBits32)
getMouseWheelEvent_which : IO Bits32
getMouseWheelEvent_which =
    mkForeign (FFun "idris_mouseWheelEvent_which" [] FBits32)
getMouseWheelEvent_x : IO Int
getMouseWheelEvent_x =
    mkForeign (FFun "idris_mouseWheelEvent_x" [] FInt)
getMouseWheelEvent_y : IO Int
getMouseWheelEvent_y =
    mkForeign (FFun "idris_mouseWheelEvent_y" [] FInt)

getMouseWheelEvent : IO Event
getMouseWheelEvent =
    [| MouseWheelEvent getMouseWheelEvent_windowID
                       getMouseWheelEvent_which
                       getMouseWheelEvent_x
                       getMouseWheelEvent_y |]


getJoyAxisEvent_which : IO Int
getJoyAxisEvent_which =
    mkForeign (FFun "idris_joyAxisEvent_which" [] FInt)
getJoyAxisEvent_axis : IO Bits8
getJoyAxisEvent_axis =
    mkForeign (FFun "idris_joyAxisEvent_axis" [] FBits8)
getJoyAxisEvent_padding1 : IO Bits8
getJoyAxisEvent_padding1 =
    mkForeign (FFun "idris_joyAxisEvent_padding1" [] FBits8)
getJoyAxisEvent_padding2 : IO Bits8
getJoyAxisEvent_padding2 =
    mkForeign (FFun "idris_joyAxisEvent_padding2" [] FBits8)
getJoyAxisEvent_padding3 : IO Bits8
getJoyAxisEvent_padding3 =
    mkForeign (FFun "idris_joyAxisEvent_padding3" [] FBits8)
getJoyAxisEvent_value : IO Bits32
getJoyAxisEvent_value =
    mkForeign (FFun "idris_joyAxisEvent_value" [] FBits32)
getJoyAxisEvent_padding4 : IO Bits16
getJoyAxisEvent_padding4 =
    mkForeign (FFun "idris_joyAxisEvent_padding4" [] FBits16)

getJoyAxisEvent : IO Event
getJoyAxisEvent =
    [| JoyAxisEvent getJoyAxisEvent_which
                    getJoyAxisEvent_axis
                    getJoyAxisEvent_padding1
                    getJoyAxisEvent_padding2
                    getJoyAxisEvent_padding3
                    getJoyAxisEvent_value
                    getJoyAxisEvent_padding4 |]


getJoyBallEvent_which : IO Int
getJoyBallEvent_which =
    mkForeign (FFun "idris_joyBallEvent_which" [] FInt)
getJoyBallEvent_ball : IO Bits8
getJoyBallEvent_ball =
    mkForeign (FFun "idris_joyBallEvent_ball" [] FBits8)
getJoyBallEvent_padding1 : IO Bits8
getJoyBallEvent_padding1 =
    mkForeign (FFun "idris_joyBallEvent_padding1" [] FBits8)
getJoyBallEvent_padding2 : IO Bits8
getJoyBallEvent_padding2 =
    mkForeign (FFun "idris_joyBallEvent_padding2" [] FBits8)
getJoyBallEvent_padding3 : IO Bits8
getJoyBallEvent_padding3 =
    mkForeign (FFun "idris_joyBallEvent_padding3" [] FBits8)
getJoyBallEvent_xrel : IO Bits32
getJoyBallEvent_xrel =
    mkForeign (FFun "idris_joyBallEvent_xrel" [] FBits32)
getJoyBallEvent_yrel : IO Bits32
getJoyBallEvent_yrel =
    mkForeign (FFun "idris_joyBallEvent_yrel" [] FBits32)

getJoyBallEvent : IO Event
getJoyBallEvent =
    [| JoyBallEvent getJoyBallEvent_which
                    getJoyBallEvent_ball
                    getJoyBallEvent_padding1
                    getJoyBallEvent_padding2
                    getJoyBallEvent_padding3
                    getJoyBallEvent_xrel
                    getJoyBallEvent_yrel |]


getJoyHatEvent_which : IO Int
getJoyHatEvent_which =
    mkForeign (FFun "idris_joyHatEvent_which" [] FInt)
getJoyHatEvent_hat : IO Bits8
getJoyHatEvent_hat =
    mkForeign (FFun "idris_joyHatEvent_hat" [] FBits8)
getJoyHatEvent_value : IO Bits8
getJoyHatEvent_value =
    mkForeign (FFun "idris_joyHatEvent_value" [] FBits8)
getJoyHatEvent_padding1 : IO Bits8
getJoyHatEvent_padding1 =
    mkForeign (FFun "idris_joyHatEvent_padding1" [] FBits8)
getJoyHatEvent_padding2 : IO Bits8
getJoyHatEvent_padding2 =
    mkForeign (FFun "idris_joyHatEvent_padding2" [] FBits8)

getJoyHatEvent : IO Event
getJoyHatEvent =
    [| JoyHatEvent getJoyHatEvent_which
                   getJoyHatEvent_hat
                   getJoyHatEvent_value
                   getJoyHatEvent_padding1
                   getJoyHatEvent_padding2 |]


getJoyButtonEvent_which : IO Int
getJoyButtonEvent_which =
    mkForeign (FFun "idris_joyButtonEvent_which" [] FInt)
getJoyButtonEvent_button : IO Bits8
getJoyButtonEvent_button =
    mkForeign (FFun "idris_joyButtonEvent_button" [] FBits8)
getJoyButtonEvent_state : IO Bits8
getJoyButtonEvent_state =
    mkForeign (FFun "idris_joyButtonEvent_state" [] FBits8)
getJoyButtonEvent_padding1 : IO Bits8
getJoyButtonEvent_padding1 =
    mkForeign (FFun "idris_joyButtonEvent_padding1" [] FBits8)
getJoyButtonEvent_padding2 : IO Bits8
getJoyButtonEvent_padding2 =
    mkForeign (FFun "idris_joyButtonEvent_padding2" [] FBits8)

getJoyButtonEvent : ButtonEventType -> IO Event
getJoyButtonEvent button =
    [| JoyButtonEvent (return button)
                      getJoyButtonEvent_which
                      getJoyButtonEvent_button
                      getJoyButtonEvent_state
                      getJoyButtonEvent_padding1
                      getJoyButtonEvent_padding2 |]


getJoyDeviceEvent_which : IO Int
getJoyDeviceEvent_which =
    mkForeign (FFun "idris_joyDeviceEvent_which" [] FInt)

getJoyDeviceEvent : JoyDeviceEventType -> IO Event
getJoyDeviceEvent type =
    [| JoyDeviceEvent (return type) getJoyDeviceEvent_which |]


getControllerAxisEvent_which : IO Int
getControllerAxisEvent_which =
    mkForeign (FFun "idris_controllerAxisEvent_which" [] FInt)
getControllerAxisEvent_axis : IO Bits8
getControllerAxisEvent_axis =
    mkForeign (FFun "idris_controllerAxisEvent_axis" [] FBits8)
getControllerAxisEvent_padding1 : IO Bits8
getControllerAxisEvent_padding1 =
    mkForeign (FFun "idris_controllerAxisEvent_padding1" [] FBits8)
getControllerAxisEvent_padding2 : IO Bits8
getControllerAxisEvent_padding2 =
    mkForeign (FFun "idris_controllerAxisEvent_padding2" [] FBits8)
getControllerAxisEvent_padding3 : IO Bits8
getControllerAxisEvent_padding3 =
    mkForeign (FFun "idris_controllerAxisEvent_padding3" [] FBits8)
getControllerAxisEvent_value : IO Bits32
getControllerAxisEvent_value =
    mkForeign (FFun "idris_controllerAxisEvent_value" [] FBits32)
getControllerAxisEvent_padding4 : IO Bits16
getControllerAxisEvent_padding4 =
    mkForeign (FFun "idris_controllerAxisEvent_padding4" [] FBits16)

getControllerAxisEvent : IO Event
getControllerAxisEvent =
    [| ControllerAxisEvent getControllerAxisEvent_which
                           getControllerAxisEvent_axis
                           getControllerAxisEvent_padding1
                           getControllerAxisEvent_padding2
                           getControllerAxisEvent_padding3
                           getControllerAxisEvent_value
                           getControllerAxisEvent_padding4 |]


getControllerButtonEvent_which : IO Int
getControllerButtonEvent_which =
    mkForeign (FFun "idris_controllerButtonEvent_which" [] FInt)
getControllerButtonEvent_button : IO Bits8
getControllerButtonEvent_button =
    mkForeign (FFun "idris_controllerButtonEvent_button" [] FBits8)
getControllerButtonEvent_state : IO Bits8
getControllerButtonEvent_state =
    mkForeign (FFun "idris_controllerButtonEvent_state" [] FBits8)
getControllerButtonEvent_padding1 : IO Bits8
getControllerButtonEvent_padding1 =
    mkForeign (FFun "idris_controllerButtonEvent_padding1" [] FBits8)
getControllerButtonEvent_padding2 : IO Bits8
getControllerButtonEvent_padding2 =
    mkForeign (FFun "idris_controllerButtonEvent_padding2" [] FBits8)

getControllerButtonEvent : ButtonEventType -> IO Event
getControllerButtonEvent button =
    [| ControllerButtonEvent (return button)
                             getControllerButtonEvent_which
                             getControllerButtonEvent_button
                             getControllerButtonEvent_state
                             getControllerButtonEvent_padding1
                             getControllerButtonEvent_padding2 |]


getControllerDeviceEvent_which : IO Int
getControllerDeviceEvent_which =
    mkForeign (FFun "idris_controllerDeviceEvent_which" [] FInt)

getControllerDeviceEvent : ControllerDeviceEventType -> IO Event
getControllerDeviceEvent type =
    [| ControllerDeviceEvent (return type) getControllerDeviceEvent_which |]


getTouchFingerEvent_touchId : IO Bits64
getTouchFingerEvent_touchId =
    mkForeign (FFun "idris_touchFingerEvent_touchId" [] FBits64)
getTouchFingerEvent_fingerId : IO Bits64
getTouchFingerEvent_fingerId =
    mkForeign (FFun "idris_touchFingerEvent_fingerId" [] FBits64)
getTouchFingerEvent_x : IO Float
getTouchFingerEvent_x =
    mkForeign (FFun "idris_touchFingerEvent_x" [] FFloat)
getTouchFingerEvent_y : IO Float
getTouchFingerEvent_y =
    mkForeign (FFun "idris_touchFingerEvent_y" [] FFloat)
getTouchFingerEvent_dx : IO Float
getTouchFingerEvent_dx =
    mkForeign (FFun "idris_touchFingerEvent_dx" [] FFloat)
getTouchFingerEvent_dy : IO Float
getTouchFingerEvent_dy =
    mkForeign (FFun "idris_touchFingerEvent_dy" [] FFloat)
getTouchFingerEvent_pressure : IO Float
getTouchFingerEvent_pressure =
    mkForeign (FFun "idris_touchFingerEvent_pressure" [] FFloat)

getTouchFingerEvent : FingerEventType -> IO Event
getTouchFingerEvent type =
    [| TouchFingerEvent (return type)
                        getTouchFingerEvent_touchId
                        getTouchFingerEvent_fingerId
                        getTouchFingerEvent_x
                        getTouchFingerEvent_y
                        getTouchFingerEvent_dx
                        getTouchFingerEvent_dy
                        getTouchFingerEvent_pressure |]


getMultiGestureEvent_touchId : IO Bits64
getMultiGestureEvent_touchId =
    mkForeign (FFun "idris_multiGestureEvent_touchId" [] FBits64)
getMultiGestureEvent_dTheta : IO Float
getMultiGestureEvent_dTheta =
    mkForeign (FFun "idris_multiGestureEvent_dTheta" [] FFloat)
getMultiGestureEvent_dDist : IO Float
getMultiGestureEvent_dDist =
    mkForeign (FFun "idris_multiGestureEvent_dDist" [] FFloat)
getMultiGestureEvent_x : IO Float
getMultiGestureEvent_x =
    mkForeign (FFun "idris_multiGestureEvent_x" [] FFloat)
getMultiGestureEvent_y : IO Float
getMultiGestureEvent_y =
    mkForeign (FFun "idris_multiGestureEvent_y" [] FFloat)
getMultiGestureEvent_numFingers : IO Bits16
getMultiGestureEvent_numFingers =
    mkForeign (FFun "idris_multiGestureEvent_numFingers" [] FBits16)
getMultiGestureEvent_padding : IO Bits16
getMultiGestureEvent_padding =
    mkForeign (FFun "idris_multiGestureEvent_padding" [] FBits16)

getMultiGestureEvent : IO Event
getMultiGestureEvent =
    [| MultiGestureEvent getMultiGestureEvent_touchId
                         getMultiGestureEvent_dTheta
                         getMultiGestureEvent_dDist
                         getMultiGestureEvent_x
                         getMultiGestureEvent_y
                         getMultiGestureEvent_numFingers
                         getMultiGestureEvent_padding |]


getDollarGestureEvent_touchId : IO Bits64
getDollarGestureEvent_touchId =
    mkForeign (FFun "idris_dollarGestureEvent_touchId" [] FBits64)
getDollarGestureEvent_gestureId : IO Bits64
getDollarGestureEvent_gestureId =
    mkForeign (FFun "idris_dollarGestureEvent_gestureId" [] FBits64)
getDollarGestureEvent_numFingers : IO Bits32
getDollarGestureEvent_numFingers =
    mkForeign (FFun "idris_dollarGestureEvent_numFingers" [] FBits32)
getDollarGestureEvent_error : IO Float
getDollarGestureEvent_error =
    mkForeign (FFun "idris_dollarGestureEvent_error" [] FFloat)
getDollarGestureEvent_x : IO Float
getDollarGestureEvent_x =
    mkForeign (FFun "idris_dollarGestureEvent_x" [] FFloat)
getDollarGestureEvent_y : IO Float
getDollarGestureEvent_y =
    mkForeign (FFun "idris_dollarGestureEvent_y" [] FFloat)

getDollarGestureEvent : GestureEventType -> IO Event
getDollarGestureEvent type =
    [| DollarGestureEvent (return type)
                          getDollarGestureEvent_touchId
                          getDollarGestureEvent_gestureId
                          getDollarGestureEvent_numFingers
                          getDollarGestureEvent_error
                          getDollarGestureEvent_x
                          getDollarGestureEvent_y |]


getDropEvent_file : IO Ptr
getDropEvent_file =
    mkForeign (FFun "idris_dropEvent_file" [] FPtr)

getDropEvent : IO Event
getDropEvent =
    [| DropEvent getDropEvent_file |]


getUserEvent_windowID : IO Bits32
getUserEvent_windowID =
    mkForeign (FFun "idris_userEvent_windowID" [] FBits32)
getUserEvent_code : IO Int
getUserEvent_code =
    mkForeign (FFun "idris_userEvent_code" [] FInt)
getUserEvent_data1 : IO Ptr
getUserEvent_data1 =
    mkForeign (FFun "idris_userEvent_data1" [] FPtr)
getUserEvent_data2 : IO Ptr
getUserEvent_data2 =
    mkForeign (FFun "idris_userEvent_data2" [] FPtr)

getUserEvent : IO Event
getUserEvent =
    [| UserEvent getUserEvent_windowID
                 getUserEvent_code
                 getUserEvent_data1
                 getUserEvent_data2 |]


getSysWMEvent_msg : IO Ptr
getSysWMEvent_msg =
    mkForeign (FFun "idris_sysWMEvent_msg" [] FPtr)

getSysWMEvent : IO Event
getSysWMEvent =
    [| SysWMEvent getSysWMEvent_msg |]

getQuitEvent : IO Event
getQuitEvent = return QuitEvent

getEvent : EventType -> IO Event
getEvent t = case t of
    Quit                     => getQuitEvent
    Window                   => getWindowEvent
    Syswm                    => getSysWMEvent
    KeyDown                  => getKeyboardEvent ButtonDown
    KeyUp                    => getKeyboardEvent ButtonUp
    TextEditing              => getTextEditingEvent
    TextInput                => getTextInputEvent
    MouseMotion              => getMouseMotionEvent
    MouseButtonDown          => getMouseButtonEvent ButtonDown
    MouseButtonUp            => getMouseButtonEvent ButtonUp
    MouseWheel               => getMouseWheelEvent
    JoyAxisMotion            => getJoyAxisEvent
    JoyBallMotion            => getJoyBallEvent
    JoyHatMotion             => getJoyHatEvent
    JoyButtonDown            => getJoyButtonEvent ButtonDown
    JoyButtonUp              => getJoyButtonEvent ButtonUp
    JoyDeviceAdded           => getJoyDeviceEvent JoyDeviceEventAdded
    JoyDeviceRemoved         => getJoyDeviceEvent JoyDeviceEventRemoved
    ControllerAxisMotion     => getControllerAxisEvent
    ControllerButtonDown     => getControllerButtonEvent ButtonDown
    ControllerButtonUp       => getControllerButtonEvent ButtonUp
    ControllerDeviceAdded    => getControllerDeviceEvent ControllerDeviceEventAdded
    ControllerDeviceRemoved  => getControllerDeviceEvent ControllerDeviceEventRemoved
    ControllerDeviceRemapped => getControllerDeviceEvent ControllerDeviceEventRemapped
    FingerDown               => getTouchFingerEvent FingerEventDown
    FingerUp                 => getTouchFingerEvent FingerEventUp
    FingerMotion             => getTouchFingerEvent FingerEventMotion
    DollarGesture            => getDollarGestureEvent GestureGesture
    DollarRecord             => getDollarGestureEvent GestureRecord
    MultiGesture             => getMultiGestureEvent
    DropFile                 => getDropEvent
    User                     => getUserEvent
    a                        => return $ UnknownEvent t
    {-
    ClipboardUpdate          => UnknownEvent t
    AppTerminating           => UnknownEvent t
    AppLowMemory             => UnknownEvent t
    AppWillEnterBackground   => UnknownEvent t
    AppDidEnterBackground    => UnknownEvent t
    AppWillEnterForeground   => UnknownEvent t
    AppDidEnterForeground    => UnknownEvent t-}


public
PollEvent : IO (Either String (Bits32, Event))
PollEvent =
    doSDLIf
        ((\x => 1 - x) `map` (mkForeign (FFun "idris_SDL_pollEvent" [] FInt)))
        (do code <- getEventType
            time <- getTimestamp
            case code of
              Left x => return $ (time, UnknownEvent AppDidEnterForeground{-fixme-})
              Right x => do
                [| (/*/) getTimestamp (getEvent x) |])

