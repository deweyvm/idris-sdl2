module Graphics.SDL.ScanCode

import Graphics.SDL.Common

data ScanCode = Unknown
              | A
              | B
              | C
              | D
              | E
              | F
              | G
              | H
              | I
              | J
              | K
              | L
              | M
              | N
              | O
              | P
              | Q
              | R
              | S
              | T
              | U
              | V
              | W
              | X
              | Y
              | Z
              | Num1
              | Num2
              | Num3
              | Num4
              | Num5
              | Num6
              | Num7
              | Num8
              | Num9
              | Num0
              | Return
              | Escape
              | Backspace
              | Tab
              | Space
              | Minus
              | Equals
              | LeftBracket
              | RightBracket
              | Backslash
              | NonUSHash
              | Semicolon
              | Apostrophe
              | Grave
              | Comma
              | Period
              | Slash
              | CapsLock
              | F1
              | F2
              | F3
              | F4
              | F5
              | F6
              | F7
              | F8
              | F9
              | F10
              | F11
              | F12
              | PrintScreen
              | ScrollLock
              | Pause
              | Insert
              | Home
              | PageUp
              | Delete
              | End
              | PageDown
              | Right
              | Left
              | Down
              | Up
              | NumLockClear
              | KPDivide
              | KPMultiply
              | KPMinus
              | KPPlus
              | KPEnter
              | KP1
              | KP2
              | KP3
              | KP4
              | KP5
              | KP6
              | KP7
              | KP8
              | KP9
              | KP0
              | KPPeriod
              | NonUSBackslash
              | Application
              | Power
              | KPEquals
              | F13
              | F14
              | F15
              | F16
              | F17
              | F18
              | F19
              | F20
              | F21
              | F22
              | F23
              | F24
              | Execute
              | Help
              | Menu
              | Select
              | Stop
              | Again
              | Undo
              | Cut
              | Copy
              | Paste
              | Find
              | Mute
              | VolumeUp
              | VolumeDown
              | KPComma
              | KPEqualsAS400
              | International1
              | International2
              | International3
              | International4
              | International5
              | International6
              | International7
              | International8
              | International9
              | Lang1
              | Lang2
              | Lang3
              | Lang4
              | Lang5
              | Lang6
              | Lang7
              | Lang8
              | Lang9
              | AltErase
              | SysReq
              | Cancel
              | Clear
              | Prior
              | Return2
              | Separator
              | Out
              | Oper
              | ClearAgain
              | CrSel
              | ExSel
              | KP00
              | KP000
              | ThousandsSeparator
              | DecimalSeparator
              | CurrencyUnit
              | CurrencySubunit
              | KPLeftParen
              | KPRightParen
              | KPLeftBrace
              | KPRightBrace
              | KPTab
              | KPBackspace
              | KPA
              | KPB
              | KPC
              | KPD
              | KPE
              | KPF
              | KPXor
              | KPPower
              | KPPercent
              | KPLess
              | KPGreater
              | KPAmpersand
              | KPDblAmpersand
              | KPVerticalBar
              | KPDblVerticalBar
              | KPColon
              | KPHash
              | KPSpace
              | KPAt
              | KPExclam
              | KPMemStore
              | KPMemRecall
              | KPMemClear
              | KPMemAdd
              | KPMemSubtract
              | KPMemMultiply
              | KPMemDivide
              | KPPlusMinus
              | KPClear
              | KPClearEntry
              | KPBinary
              | KPOctal
              | KPDecimal
              | KPHexadecimal
              | LCtrl
              | LShift
              | LAlt
              | LGui
              | RCtrl
              | RShift
              | RAlt
              | RGui
              | Mode
              | AudioNext
              | AudioPrev
              | AudioStop
              | AudioPlay
              | AudioMute
              | MediaSelect
              | WWW
              | Mail
              | Calculator
              | Computer
              | AcSearch
              | AcHome
              | AcBack
              | AcForward
              | AcStop
              | AcRefresh
              | AcBookmarks
              | BrightnessDown
              | BrightnessUp
              | DisplaySwitch
              | KbDIllumToggle
              | KbDIllumDown
              | KbDIllumUp
              | Eject
              | Sleep
              | App1
              | App2

instance Enumerable ScanCode where
    enumerate = [Unknown, A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z, Num1, Num2, Num3, Num4, Num5, Num6, Num7, Num8, Num9, Num0, Return, Escape, Backspace, Tab, Space, Minus, Equals, LeftBracket, RightBracket, Backslash, NonUSHash, Semicolon, Apostrophe, Grave, Comma, Period, Slash, CapsLock, F1, F2, F3, F4, F5, F6, F7, F8, F9, F10, F11, F12, PrintScreen, ScrollLock, Pause, Insert, Home, PageUp, Delete, End, PageDown, Right, Left, Down, Up, NumLockClear, KPDivide, KPMultiply, KPMinus, KPPlus, KPEnter, KP1, KP2, KP3, KP4, KP5, KP6, KP7, KP8, KP9, KP0, KPPeriod, NonUSBackslash, Application, Power, KPEquals, F13, F14, F15, F16, F17, F18, F19, F20, F21, F22, F23, F24, Execute, Help, Menu, Select, Stop, Again, Undo, Cut, Copy, Paste, Find, Mute, VolumeUp, VolumeDown, KPComma, KPEqualsAS400, International1, International2, International3, International4, International5, International6, International7, International8, International9, Lang1, Lang2, Lang3, Lang4, Lang5, Lang6, Lang7, Lang8, Lang9, AltErase, SysReq, Cancel, Clear, Prior, Return2, Separator, Out, Oper, ClearAgain, CrSel, ExSel, KP00, KP000, ThousandsSeparator, DecimalSeparator, CurrencyUnit, CurrencySubunit, KPLeftParen, KPRightParen, KPLeftBrace, KPRightBrace, KPTab, KPBackspace, KPA, KPB, KPC, KPD, KPE, KPF, KPXor, KPPower, KPPercent, KPLess, KPGreater, KPAmpersand, KPDblAmpersand, KPVerticalBar, KPDblVerticalBar, KPColon, KPHash, KPSpace, KPAt, KPExclam, KPMemStore, KPMemRecall, KPMemClear, KPMemAdd, KPMemSubtract, KPMemMultiply, KPMemDivide, KPPlusMinus, KPClear, KPClearEntry, KPBinary, KPOctal, KPDecimal, KPHexadecimal, LCtrl, LShift, LAlt, LGui, RCtrl, RShift, RAlt, RGui, Mode, AudioNext, AudioPrev, AudioStop, AudioPlay, AudioMute, MediaSelect, WWW, Mail, Calculator, Computer, AcSearch, AcHome, AcBack, AcForward, AcStop, AcRefresh, AcBookmarks, BrightnessDown, BrightnessUp, DisplaySwitch, KbDIllumToggle, KbDIllumDown, KbDIllumUp, Eject, Sleep, App1, App2]

instance Flag Bits32 ScanCode where
    toFlag Unknown            = 0
    toFlag A                  = 4
    toFlag B                  = 5
    toFlag C                  = 6
    toFlag D                  = 7
    toFlag E                  = 8
    toFlag F                  = 9
    toFlag G                  = 10
    toFlag H                  = 11
    toFlag I                  = 12
    toFlag J                  = 13
    toFlag K                  = 14
    toFlag L                  = 15
    toFlag M                  = 16
    toFlag N                  = 17
    toFlag O                  = 18
    toFlag P                  = 19
    toFlag Q                  = 20
    toFlag R                  = 21
    toFlag S                  = 22
    toFlag T                  = 23
    toFlag U                  = 24
    toFlag V                  = 25
    toFlag W                  = 26
    toFlag X                  = 27
    toFlag Y                  = 28
    toFlag Z                  = 29
    toFlag Num1               = 30
    toFlag Num2               = 31
    toFlag Num3               = 32
    toFlag Num4               = 33
    toFlag Num5               = 34
    toFlag Num6               = 35
    toFlag Num7               = 36
    toFlag Num8               = 37
    toFlag Num9               = 38
    toFlag Num0               = 39
    toFlag Return             = 40
    toFlag Escape             = 41
    toFlag Backspace          = 42
    toFlag Tab                = 43
    toFlag Space              = 44
    toFlag Minus              = 45
    toFlag Equals             = 46
    toFlag LeftBracket        = 47
    toFlag RightBracket       = 48
    toFlag Backslash          = 49
    toFlag NonUSHash          = 50
    toFlag Semicolon          = 51
    toFlag Apostrophe         = 52
    toFlag Grave              = 53
    toFlag Comma              = 54
    toFlag Period             = 55
    toFlag Slash              = 56
    toFlag CapsLock           = 57
    toFlag F1                 = 58
    toFlag F2                 = 59
    toFlag F3                 = 60
    toFlag F4                 = 61
    toFlag F5                 = 62
    toFlag F6                 = 63
    toFlag F7                 = 64
    toFlag F8                 = 65
    toFlag F9                 = 66
    toFlag F10                = 67
    toFlag F11                = 68
    toFlag F12                = 69
    toFlag PrintScreen        = 70
    toFlag ScrollLock         = 71
    toFlag Pause              = 72
    toFlag Insert             = 73
    toFlag Home               = 74
    toFlag PageUp             = 75
    toFlag Delete             = 76
    toFlag End                = 77
    toFlag PageDown           = 78
    toFlag Right              = 79
    toFlag Left               = 80
    toFlag Down               = 81
    toFlag Up                 = 82
    toFlag NumLockClear       = 83
    toFlag KPDivide           = 84
    toFlag KPMultiply         = 85
    toFlag KPMinus            = 86
    toFlag KPPlus             = 87
    toFlag KPEnter            = 88
    toFlag KP1                = 89
    toFlag KP2                = 90
    toFlag KP3                = 91
    toFlag KP4                = 92
    toFlag KP5                = 93
    toFlag KP6                = 94
    toFlag KP7                = 95
    toFlag KP8                = 96
    toFlag KP9                = 97
    toFlag KP0                = 98
    toFlag KPPeriod           = 9
    toFlag NonUSBackslash     = 100
    toFlag Application        = 101
    toFlag Power              = 10
    toFlag KPEquals           = 103
    toFlag F13                = 104
    toFlag F14                = 105
    toFlag F15                = 106
    toFlag F16                = 107
    toFlag F17                = 108
    toFlag F18                = 109
    toFlag F19                = 110
    toFlag F20                = 111
    toFlag F21                = 112
    toFlag F22                = 113
    toFlag F23                = 114
    toFlag F24                = 115
    toFlag Execute            = 116
    toFlag Help               = 117
    toFlag Menu               = 118
    toFlag Select             = 119
    toFlag Stop               = 120
    toFlag Again              = 121
    toFlag Undo               = 122
    toFlag Cut                = 123
    toFlag Copy               = 124
    toFlag Paste              = 125
    toFlag Find               = 126
    toFlag Mute               = 127
    toFlag VolumeUp           = 128
    toFlag VolumeDown         = 129
    toFlag KPComma            = 133
    toFlag KPEqualsAS400      = 134
    toFlag International1     = 135
    toFlag International2     = 136
    toFlag International3     = 137
    toFlag International4     = 138
    toFlag International5     = 139
    toFlag International6     = 140
    toFlag International7     = 141
    toFlag International8     = 142
    toFlag International9     = 143
    toFlag Lang1              = 144
    toFlag Lang2              = 145
    toFlag Lang3              = 146
    toFlag Lang4              = 147
    toFlag Lang5              = 148
    toFlag Lang6              = 149
    toFlag Lang7              = 150
    toFlag Lang8              = 151
    toFlag Lang9              = 152
    toFlag AltErase           = 153
    toFlag SysReq             = 154
    toFlag Cancel             = 155
    toFlag Clear              = 156
    toFlag Prior              = 157
    toFlag Return2            = 158
    toFlag Separator          = 159
    toFlag Out                = 160
    toFlag Oper               = 161
    toFlag ClearAgain         = 162
    toFlag CrSel              = 163
    toFlag ExSel              = 164
    toFlag KP00               = 176
    toFlag KP000              = 177
    toFlag ThousandsSeparator = 178
    toFlag DecimalSeparator   = 179
    toFlag CurrencyUnit       = 180
    toFlag CurrencySubunit    = 181
    toFlag KPLeftParen        = 182
    toFlag KPRightParen       = 183
    toFlag KPLeftBrace        = 184
    toFlag KPRightBrace       = 185
    toFlag KPTab              = 186
    toFlag KPBackspace        = 187
    toFlag KPA                = 188
    toFlag KPB                = 189
    toFlag KPC                = 190
    toFlag KPD                = 191
    toFlag KPE                = 192
    toFlag KPF                = 193
    toFlag KPXor              = 194
    toFlag KPPower            = 195
    toFlag KPPercent          = 196
    toFlag KPLess             = 197
    toFlag KPGreater          = 198
    toFlag KPAmpersand        = 199
    toFlag KPDblAmpersand     = 200
    toFlag KPVerticalBar      = 201
    toFlag KPDblVerticalBar   = 202
    toFlag KPColon            = 203
    toFlag KPHash             = 204
    toFlag KPSpace            = 205
    toFlag KPAt               = 206
    toFlag KPExclam           = 207
    toFlag KPMemStore         = 208
    toFlag KPMemRecall        = 209
    toFlag KPMemClear         = 210
    toFlag KPMemAdd           = 211
    toFlag KPMemSubtract      = 212
    toFlag KPMemMultiply      = 213
    toFlag KPMemDivide        = 214
    toFlag KPPlusMinus        = 215
    toFlag KPClear            = 216
    toFlag KPClearEntry       = 217
    toFlag KPBinary           = 218
    toFlag KPOctal            = 219
    toFlag KPDecimal          = 220
    toFlag KPHexadecimal      = 221
    toFlag LCtrl              = 224
    toFlag LShift             = 225
    toFlag LAlt               = 226
    toFlag LGui               = 227
    toFlag RCtrl              = 228
    toFlag RShift             = 229
    toFlag RAlt               = 230
    toFlag RGui               = 231
    toFlag Mode               = 257
    toFlag AudioNext          = 258
    toFlag AudioPrev          = 259
    toFlag AudioStop          = 260
    toFlag AudioPlay          = 261
    toFlag AudioMute          = 262
    toFlag MediaSelect        = 263
    toFlag WWW                = 264
    toFlag Mail               = 265
    toFlag Calculator         = 266
    toFlag Computer           = 267
    toFlag AcSearch           = 268
    toFlag AcHome             = 269
    toFlag AcBack             = 270
    toFlag AcForward          = 271
    toFlag AcStop             = 272
    toFlag AcRefresh          = 273
    toFlag AcBookmarks        = 274
    toFlag BrightnessDown     = 275
    toFlag BrightnessUp       = 276
    toFlag DisplaySwitch      = 277
    toFlag KbDIllumToggle     = 278
    toFlag KbDIllumDown       = 279
    toFlag KbDIllumUp         = 280
    toFlag Eject              = 281
    toFlag Sleep              = 282
    toFlag App1               = 283
    toFlag App2               = 284

numScanCodes : Bits32
numScanCodes = foldl max 0 (map toFlag enumerate {a=ScanCode})
