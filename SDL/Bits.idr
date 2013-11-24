module SDL.Bits

import SDL.Common

%include C "SDL2/SDL_bits.h"

public
MostSignificantBitIndex32 : Bits32 -> Int
MostSignificantBitIndex32 bits = unsafePerformIO (mkForeign (FFun "idris_SDL_MostSignificantBitIndex32" [FBits32] FInt) bits)