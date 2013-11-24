module SDL.CPUInfo

import SDL.Common

%include C "SDL2/SDL_cpuinfo.h"

public
GetCPUCount : IO Int
GetCPUCount = mkForeign (FFun "SDL_GetCPUCount" [] FInt)

public
GetCPUCacheLineSize : IO Int
GetCPUCacheLineSize = mkForeign (FFun "SDL_GetCPUCacheLineSize" [] FInt)

public
HasRDTSC : IO Bool
HasRDTSC = do
    [| fromSDLBool (mkForeign (FFun "SDL_HasRDTSC" [] FInt)) |]

public
HasAltiVec : IO Bool
HasAltiVec = do
    [| fromSDLBool (mkForeign (FFun "SDL_HasAltiVec" [] FInt)) |]

public
HasMMX : IO Bool
HasMMX = do
    [| fromSDLBool (mkForeign (FFun "SDL_HasMMX" [] FInt)) |]

public
Has3DNow : IO Bool
Has3DNow = do
    [| fromSDLBool (mkForeign (FFun "SDL_Has3DNow" [] FInt)) |]

public
HasSSE : IO Bool
HasSSE = do
    [| fromSDLBool (mkForeign (FFun "SDL_HasSSE" [] FInt)) |]

public
HasSSE2 : IO Bool
HasSSE2 = do
    [| fromSDLBool (mkForeign (FFun "SDL_HasSSE2" [] FInt)) |]

public
HasSSE3 : IO Bool
HasSSE3 = do
    [| fromSDLBool (mkForeign (FFun "SDL_HasSSE3" [] FInt)) |]

public
HasSSE41 : IO Bool
HasSSE41 = do
    [| fromSDLBool (mkForeign (FFun "SDL_HasSSE41" [] FInt)) |]

public
HasSSE42 : IO Bool
HasSSE42 = do
    [| fromSDLBool (mkForeign (FFun "SDL_HasSSE42" [] FInt)) |]
