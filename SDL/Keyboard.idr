module SDL.Keyboard

import SDL.Common
import SDL.ScanCode
import SDL.KeyCode

public
data KeySym = mkKeySym ScanCode KeyCode (List KeyMod)

