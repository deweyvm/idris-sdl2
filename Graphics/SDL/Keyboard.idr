module Graphics.SDL.Keyboard

import Graphics.SDL.Common
import Graphics.SDL.ScanCode
import Graphics.SDL.KeyCode

public
data KeySym = mkKeySym ScanCode KeyCode (List KeyMod)

