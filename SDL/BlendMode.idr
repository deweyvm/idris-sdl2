module SDL.BlendMode

import SDL.Common

data BlendMode = BlendModeNone
               | BlendModeBlend
               | BlendModeAdd
               | BlendModeMod

instance Flag BlendMode where
    toBits BlendModeNone  = 0x0
    toBits BlendModeBlend = 0x1
    toBits BlendModeAdd   = 0x2
    toBits BlendModeMod   = 0x4
