module SDL.Events

import SDL.Common

%include C "SDL2/SDL_events.h"

data EventType = FirstEvent
               | Quit
               | AppTerminating
               | AppLowMemory
               | AppWillEnterBackground
               | AppDidEnterBackground
               | AppWillEnterForeground
               | AppDidEnterForeground
               | WindowEvent
               | SyswmEvent
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
               | UserEvent
               | LastEvent

instance Flag Bits32 EventType where
    toFlag FirstEvent               = 0x000
    toFlag Quit                     = 0x100
    toFlag AppTerminating           = 0x101
    toFlag AppLowMemory             = 0x102
    toFlag AppWillEnterBackground   = 0x103
    toFlag AppDidEnterBackground    = 0x104
    toFlag AppWillEnterForeground   = 0x105
    toFlag AppDidEnterForeground    = 0x106
    toFlag WindowEvent              = 0x200
    toFlag SyswmEvent               = 0x201
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
    toFlag UserEvent                = 0x8000
    toFlag LastEvent                = 0xFFFF

data Event = CommonEvent Bits32 Bits32


public
PumpEvents : IO ()
PumpEvents = mkForeign (FFun "SDL_PumpEvents" [] FUnit)

--int SDLCALL SDL_PeepEvents(SDL_Event * events, int numevents, SDL_eventaction action, Uint32 minType, Uint32 maxType);

public
HasEvent : EventType -> IO Bool
HasEvent t = do
    [| fromSDLBool (mkForeign (FFun "SDL_HasEvent" [FBits32] FInt) (toFlag t)) |]

--should use some generalized filterM here
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
