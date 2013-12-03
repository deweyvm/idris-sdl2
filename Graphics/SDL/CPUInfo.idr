module Graphics.SDL.CPUInfo

import Graphics.SDL.Common

%include C "SDL2/SDL_cpuinfo.h"

public
getCPUCount : IO Int
getCPUCount = mkForeign (FFun "SDL_GetCPUCount" [] FInt)

public
getCPUCacheLineSize : IO Int
getCPUCacheLineSize = mkForeign (FFun "SDL_GetCPUCacheLineSize" [] FInt)

public
hasRDTSC : IO Bool
hasRDTSC = do
    [| fromSDLBool (mkForeign (FFun "SDL_HasRDTSC" [] FInt)) |]

public
hasAltiVec : IO Bool
hasAltiVec = do
    [| fromSDLBool (mkForeign (FFun "SDL_HasAltiVec" [] FInt)) |]

public
hasMMX : IO Bool
hasMMX = do
    [| fromSDLBool (mkForeign (FFun "SDL_HasMMX" [] FInt)) |]

public
has3DNow : IO Bool
has3DNow = do
    [| fromSDLBool (mkForeign (FFun "SDL_Has3DNow" [] FInt)) |]

public
hasSSE : IO Bool
hasSSE = do
    [| fromSDLBool (mkForeign (FFun "SDL_HasSSE" [] FInt)) |]

public
hasSSE2 : IO Bool
hasSSE2 = do
    [| fromSDLBool (mkForeign (FFun "SDL_HasSSE2" [] FInt)) |]

public
hasSSE3 : IO Bool
hasSSE3 = do
    [| fromSDLBool (mkForeign (FFun "SDL_HasSSE3" [] FInt)) |]

public
hasSSE41 : IO Bool
hasSSE41 = do
    [| fromSDLBool (mkForeign (FFun "SDL_HasSSE41" [] FInt)) |]

public
hasSSE42 : IO Bool
hasSSE42 = do
    [| fromSDLBool (mkForeign (FFun "SDL_HasSSE42" [] FInt)) |]
