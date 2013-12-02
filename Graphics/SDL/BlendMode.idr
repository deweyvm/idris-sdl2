module Graphics.SDL.BlendMode

import Graphics.SDL.Common

data BlendMode = BlendModeNone
               | BlendModeBlend
               | BlendModeAdd
               | BlendModeMod

instance Flag Bits32 BlendMode where
    toFlag BlendModeNone  = 0x0
    toFlag BlendModeBlend = 0x1
    toFlag BlendModeAdd   = 0x2
    toFlag BlendModeMod   = 0x4


instance Enumerable BlendMode where
    enumerate = [BlendModeNone, BlendModeBlend, BlendModeAdd, BlendModeMod]
