module SDL.Events

import SDL.Common
import Prelude.Applicative

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

instance Flag EventType where
    toBits FirstEvent               = 0x000
    toBits Quit                     = 0x100
    toBits AppTerminating           = 0x101
    toBits AppLowMemory             = 0x102
    toBits AppWillEnterBackground   = 0x103
    toBits AppDidEnterBackground    = 0x104
    toBits AppWillEnterForeground   = 0x105
    toBits AppDidEnterForeground    = 0x106
    toBits WindowEvent              = 0x200
    toBits SyswmEvent               = 0x201
    toBits KeyDown                  = 0x300
    toBits KeyUp                    = 0x301
    toBits TextEditing              = 0x302
    toBits TextInput                = 0x303
    toBits MouseMotion              = 0x400
    toBits MouseButtonDown          = 0x401
    toBits MouseButtonUp            = 0x402
    toBits MouseWheel               = 0x403
    toBits JoyAxisMotion            = 0x600
    toBits JoyBallMotion            = 0x601
    toBits JoyHatMotion             = 0x602
    toBits JoyButtonDown            = 0x603
    toBits JoyButtonUp              = 0x604
    toBits JoyDeviceAdded           = 0x605
    toBits JoyDeviceRemoved         = 0x606
    toBits ControllerAxisMotion     = 0x650
    toBits ControllerButtonDown     = 0x651
    toBits ControllerButtonUp       = 0x652
    toBits ControllerDeviceAdded    = 0x653
    toBits ControllerDeviceRemoved  = 0x654
    toBits ControllerDeviceRemapped = 0x655
    toBits FingerDown               = 0x700
    toBits FingerUp                 = 0x701
    toBits FingerMotion             = 0x702
    toBits DollarGesture            = 0x800
    toBits DollarRecord             = 0x801
    toBits MultiGesture             = 0x802
    toBits ClipboardUpdate          = 0x900
    toBits DropFile                 = 0x1000
    toBits UserEvent                = 0x8000
    toBits LastEvent                = 0xFFFF

data Event = CommonEvent Bits32 Bits32


public
PumpEvents : IO ()
PumpEvents = mkForeign (FFun "SDL_PumpEvents" [] FUnit)

--int SDLCALL SDL_PeepEvents(SDL_Event * events, int numevents, SDL_eventaction action, Uint32 minType, Uint32 maxType);

public
HasEvent : EventType -> IO Bool
HasEvent t = do
    [| fromSDLBool (mkForeign (FFun "SDL_HasEvent" [FBits32] FInt) (toBits t)) |]

--should use some generalized filterM here
findA : (Applicative f, Traversable ls) => (a -> f Bool) -> ls a -> f Bool
findA fun xs = (map (any id)) (sequence (map fun xs))

public
HasEvents : List EventType -> IO Bool
HasEvents xs = findA HasEvent xs

public
FlushEvent : EventType -> IO ()
FlushEvent t = mkForeign (FFun "SDL_FlushEvent" [FBits32] FUnit) (toBits t)

public
FlushEvents : List EventType -> IO ()
FlushEvents xs = sequence_ (map FlushEvent xs)
