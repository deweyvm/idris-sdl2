module Graphics.SDL.Bits

import Graphics.SDL.Common

%include C "SDL2/SDL_bits.h"
%include C "csrc/idris_SDL_bits.h"
%link C "idris_SDL_bits.o"


public
MostSignificantBitIndex32 : Bits32 -> Int
MostSignificantBitIndex32 bits = unsafePerformIO (mkForeign (FFun "idris_SDL_mostSignificantBitIndex32" [FBits32] FInt) bits)
