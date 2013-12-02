module Graphics.SDL.KeyCode

import Graphics.SDL.Common


data KeyCode = Unknown
             | Return
             | Escape
             | Backspace
             | Tab
             | Space
             | Exclaim
             | QuoteDbl
             | Hash
             | Percent
             | Dollar
             | Ampersand
             | Quote
             | LeftParen
             | RightParen
             | Asterisk
             | Plus
             | Comma
             | Minus
             | Period
             | Slash
             | Num0
             | Num1
             | Num2
             | Num3
             | Num4
             | Num5
             | Num6
             | Num7
             | Num8
             | Num9
             | Colon
             | Semicolon
             | Less
             | Equals
             | Greater
             | Question
             | At
             | LeftBracket
             | Backslash
             | RightBracket
             | Caret
             | Underscore
             | Backquote
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
             | KpDivide
             | KpMultiply
             | KpMinus
             | KpPlus
             | KpEnter
             | Kp1
             | Kp2
             | Kp3
             | Kp4
             | Kp5
             | Kp6
             | Kp7
             | Kp8
             | Kp9
             | Kp0
             | KpPeriod
             | Application
             | Power
             | KpEquals
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
             | KpComma
             | KpEqualsAS400
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
             | Kp00
             | Kp000
             | ThousandsSeparator
             | DecimalSeparator
             | CurrencyUnit
             | CurrencySubunit
             | KpLeftParen
             | KpRightParen
             | KpLeftBrace
             | KpRightBrace
             | KpTab
             | KpBackspace
             | KpA
             | KpB
             | KpC
             | KpD
             | KpE
             | KpF
             | KpXor
             | KpPower
             | KpPercent
             | KpLess
             | KpGreater
             | KpAmpersand
             | KpDblAmpersand
             | KpVerticalBar
             | KpDblverticalbar
             | KpColon
             | KpHash
             | KpSpace
             | KpAt
             | KpExclam
             | KpMemStore
             | KpMemRecall
             | KpMemClear
             | KpMemAdd
             | KpMemSubtract
             | KpMemMultiply
             | KpMemDivide
             | KpPlusMinus
             | KpClear
             | KpClearEntry
             | KpBinary
             | KpOctal
             | KpDecimal
             | KpHexadecimal
             | LCtrl
             | LShift
             | LAlt
             | LGui
             | RCtrl
             | RShift
             | RAlt
             | RGui
             | Mode
             | AudionExt
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

instance Flag Bits32 KeyCode where
    toFlag Unknown            = 0x00000000
    toFlag Return             = 0x0000000D
    toFlag Escape             = 0x0000001B
    toFlag Backspace          = 0x00000008
    toFlag Tab                = 0x00000009
    toFlag Space              = 0x00000020
    toFlag Exclaim            = 0x00000021
    toFlag QuoteDbl           = 0x00000022
    toFlag Hash               = 0x00000023
    toFlag Percent            = 0x00000025
    toFlag Dollar             = 0x00000024
    toFlag Ampersand          = 0x00000026
    toFlag Quote              = 0x00000027
    toFlag LeftParen          = 0x00000028
    toFlag RightParen         = 0x00000029
    toFlag Asterisk           = 0x0000002A
    toFlag Plus               = 0x0000002B
    toFlag Comma              = 0x0000002C
    toFlag Minus              = 0x0000002D
    toFlag Period             = 0x0000002E
    toFlag Slash              = 0x0000002F
    toFlag Num0               = 0x00000030
    toFlag Num1               = 0x00000031
    toFlag Num2               = 0x00000032
    toFlag Num3               = 0x00000033
    toFlag Num4               = 0x00000034
    toFlag Num5               = 0x00000035
    toFlag Num6               = 0x00000036
    toFlag Num7               = 0x00000037
    toFlag Num8               = 0x00000038
    toFlag Num9               = 0x00000039
    toFlag Colon              = 0x0000003A
    toFlag Semicolon          = 0x0000003B
    toFlag Less               = 0x0000003C
    toFlag Equals             = 0x0000003D
    toFlag Greater            = 0x0000003E
    toFlag Question           = 0x0000003F
    toFlag At                 = 0x00000040
    toFlag LeftBracket        = 0x0000005B
    toFlag Backslash          = 0x0000005C
    toFlag RightBracket       = 0x0000005D
    toFlag Caret              = 0x0000005E
    toFlag Underscore         = 0x0000005F
    toFlag Backquote          = 0x00000060
    toFlag A                  = 0x00000061
    toFlag B                  = 0x00000062
    toFlag C                  = 0x00000063
    toFlag D                  = 0x00000064
    toFlag E                  = 0x00000065
    toFlag F                  = 0x00000066
    toFlag G                  = 0x00000067
    toFlag H                  = 0x00000068
    toFlag I                  = 0x00000069
    toFlag J                  = 0x0000006A
    toFlag K                  = 0x0000006B
    toFlag L                  = 0x0000006C
    toFlag M                  = 0x0000006D
    toFlag N                  = 0x0000006E
    toFlag O                  = 0x0000006F
    toFlag P                  = 0x00000070
    toFlag Q                  = 0x00000071
    toFlag R                  = 0x00000072
    toFlag S                  = 0x00000073
    toFlag T                  = 0x00000074
    toFlag U                  = 0x00000075
    toFlag V                  = 0x00000076
    toFlag W                  = 0x00000077
    toFlag X                  = 0x00000078
    toFlag Y                  = 0x00000079
    toFlag Z                  = 0x0000007A
    toFlag CapsLock           = 0x40000039
    toFlag F1                 = 0x4000003A
    toFlag F2                 = 0x4000003B
    toFlag F3                 = 0x4000003C
    toFlag F4                 = 0x4000003D
    toFlag F5                 = 0x4000003E
    toFlag F6                 = 0x4000003F
    toFlag F7                 = 0x40000040
    toFlag F8                 = 0x40000041
    toFlag F9                 = 0x40000042
    toFlag F10                = 0x40000043
    toFlag F11                = 0x40000044
    toFlag F12                = 0x40000045
    toFlag PrintScreen        = 0x40000046
    toFlag ScrollLock         = 0x40000047
    toFlag Pause              = 0x40000048
    toFlag Insert             = 0x40000049
    toFlag Home               = 0x4000004A
    toFlag PageUp             = 0x4000004B
    toFlag Delete             = 0x0000007F
    toFlag End                = 0x4000004D
    toFlag PageDown           = 0x4000004E
    toFlag Right              = 0x4000004F
    toFlag Left               = 0x40000050
    toFlag Down               = 0x40000051
    toFlag Up                 = 0x40000052
    toFlag NumLockClear       = 0x40000053
    toFlag KpDivide           = 0x40000054
    toFlag KpMultiply         = 0x40000055
    toFlag KpMinus            = 0x40000056
    toFlag KpPlus             = 0x40000057
    toFlag KpEnter            = 0x40000058
    toFlag Kp1                = 0x40000059
    toFlag Kp2                = 0x4000005A
    toFlag Kp3                = 0x4000005B
    toFlag Kp4                = 0x4000005C
    toFlag Kp5                = 0x4000005D
    toFlag Kp6                = 0x4000005E
    toFlag Kp7                = 0x4000005F
    toFlag Kp8                = 0x40000060
    toFlag Kp9                = 0x40000061
    toFlag Kp0                = 0x40000062
    toFlag KpPeriod           = 0x40000063
    toFlag Application        = 0x40000065
    toFlag Power              = 0x40000066
    toFlag KpEquals           = 0x40000067
    toFlag F13                = 0x40000068
    toFlag F14                = 0x40000069
    toFlag F15                = 0x4000006A
    toFlag F16                = 0x4000006B
    toFlag F17                = 0x4000006C
    toFlag F18                = 0x4000006D
    toFlag F19                = 0x4000006E
    toFlag F20                = 0x4000006F
    toFlag F21                = 0x40000070
    toFlag F22                = 0x40000071
    toFlag F23                = 0x40000072
    toFlag F24                = 0x40000073
    toFlag Execute            = 0x40000074
    toFlag Help               = 0x40000075
    toFlag Menu               = 0x40000076
    toFlag Select             = 0x40000077
    toFlag Stop               = 0x40000078
    toFlag Again              = 0x40000079
    toFlag Undo               = 0x4000007A
    toFlag Cut                = 0x4000007B
    toFlag Copy               = 0x4000007C
    toFlag Paste              = 0x4000007D
    toFlag Find               = 0x4000007E
    toFlag Mute               = 0x4000007F
    toFlag VolumeUp           = 0x40000080
    toFlag VolumeDown         = 0x40000081
    toFlag KpComma            = 0x40000085
    toFlag KpEqualsAS400      = 0x40000086
    toFlag AltErase           = 0x40000099
    toFlag SysReq             = 0x4000009A
    toFlag Cancel             = 0x4000009B
    toFlag Clear              = 0x4000009C
    toFlag Prior              = 0x4000009D
    toFlag Return2            = 0x4000009E
    toFlag Separator          = 0x4000009F
    toFlag Out                = 0x400000A0
    toFlag Oper               = 0x400000A1
    toFlag ClearAgain         = 0x400000A2
    toFlag CrSel              = 0x400000A3
    toFlag ExSel              = 0x400000A4
    toFlag Kp00               = 0x400000B0
    toFlag Kp000              = 0x400000B1
    toFlag ThousandsSeparator = 0x400000B2
    toFlag DecimalSeparator   = 0x400000B3
    toFlag CurrencyUnit       = 0x400000B4
    toFlag CurrencySubunit    = 0x400000B5
    toFlag KpLeftParen        = 0x400000B6
    toFlag KpRightParen       = 0x400000B7
    toFlag KpLeftBrace        = 0x400000B8
    toFlag KpRightBrace       = 0x400000B9
    toFlag KpTab              = 0x400000BA
    toFlag KpBackspace        = 0x400000BB
    toFlag KpA                = 0x400000BC
    toFlag KpB                = 0x400000BD
    toFlag KpC                = 0x400000BE
    toFlag KpD                = 0x400000BF
    toFlag KpE                = 0x400000C0
    toFlag KpF                = 0x400000C1
    toFlag KpXor              = 0x400000C2
    toFlag KpPower            = 0x400000C3
    toFlag KpPercent          = 0x400000C4
    toFlag KpLess             = 0x400000C5
    toFlag KpGreater          = 0x400000C6
    toFlag KpAmpersand        = 0x400000C7
    toFlag KpDblAmpersand     = 0x400000C8
    toFlag KpVerticalBar      = 0x400000C9
    toFlag KpDblverticalbar   = 0x400000CA
    toFlag KpColon            = 0x400000CB
    toFlag KpHash             = 0x400000CC
    toFlag KpSpace            = 0x400000CD
    toFlag KpAt               = 0x400000CE
    toFlag KpExclam           = 0x400000CF
    toFlag KpMemStore         = 0x400000D0
    toFlag KpMemRecall        = 0x400000D1
    toFlag KpMemClear         = 0x400000D2
    toFlag KpMemAdd           = 0x400000D3
    toFlag KpMemSubtract      = 0x400000D4
    toFlag KpMemMultiply      = 0x400000D5
    toFlag KpMemDivide        = 0x400000D6
    toFlag KpPlusMinus        = 0x400000D7
    toFlag KpClear            = 0x400000D8
    toFlag KpClearEntry       = 0x400000D9
    toFlag KpBinary           = 0x400000DA
    toFlag KpOctal            = 0x400000DB
    toFlag KpDecimal          = 0x400000DC
    toFlag KpHexadecimal      = 0x400000DD
    toFlag LCtrl              = 0x400000E0
    toFlag LShift             = 0x400000E1
    toFlag LAlt               = 0x400000E2
    toFlag LGui               = 0x400000E3
    toFlag RCtrl              = 0x400000E4
    toFlag RShift             = 0x400000E5
    toFlag RAlt               = 0x400000E6
    toFlag RGui               = 0x400000E7
    toFlag Mode               = 0x40000101
    toFlag AudionExt          = 0x40000102
    toFlag AudioPrev          = 0x40000103
    toFlag AudioStop          = 0x40000104
    toFlag AudioPlay          = 0x40000105
    toFlag AudioMute          = 0x40000106
    toFlag MediaSelect        = 0x40000107
    toFlag WWW                = 0x40000108
    toFlag Mail               = 0x40000109
    toFlag Calculator         = 0x4000010A
    toFlag Computer           = 0x4000010B
    toFlag AcSearch           = 0x4000010C
    toFlag AcHome             = 0x4000010D
    toFlag AcBack             = 0x4000010E
    toFlag AcForward          = 0x4000010F
    toFlag AcStop             = 0x40000110
    toFlag AcRefresh          = 0x40000111
    toFlag AcBookmarks        = 0x40000112
    toFlag BrightnessDown     = 0x40000113
    toFlag BrightnessUp       = 0x40000114
    toFlag DisplaySwitch      = 0x40000115
    toFlag KbDIllumToggle     = 0x40000116
    toFlag KbDIllumDown       = 0x40000117
    toFlag KbDIllumUp         = 0x40000118
    toFlag Eject              = 0x40000119
    toFlag Sleep              = 0x4000011A

instance Enumerable KeyCode where
    enumerate = [Unknown, Return, Escape, Backspace, Tab, Space, Exclaim, QuoteDbl, Hash, Percent, Dollar, Ampersand, Quote, LeftParen, RightParen, Asterisk, Plus, Comma, Minus, Period, Slash, Num0, Num1, Num2, Num3, Num4, Num5, Num6, Num7, Num8, Num9, Colon, Semicolon, Less, Equals, Greater, Question, At, LeftBracket, Backslash, RightBracket, Caret, Underscore, Backquote, A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z, CapsLock, F1, F2, F3, F4, F5, F6, F7, F8, F9, F10, F11, F12, PrintScreen, ScrollLock, Pause, Insert, Home, PageUp, Delete, End, PageDown, Right, Left, Down, Up, NumLockClear, KpDivide, KpMultiply, KpMinus, KpPlus, KpEnter, Kp1, Kp2, Kp3, Kp4, Kp5, Kp6, Kp7, Kp8, Kp9, Kp0, KpPeriod, Application, Power, KpEquals, F13, F14, F15, F16, F17, F18, F19, F20, F21, F22, F23, F24, Execute, Help, Menu, Select, Stop, Again, Undo, Cut, Copy, Paste, Find, Mute, VolumeUp, VolumeDown, KpComma, KpEqualsAS400, AltErase, SysReq, Cancel, Clear, Prior, Return2, Separator, Out, Oper, ClearAgain, CrSel, ExSel, Kp00, Kp000, ThousandsSeparator, DecimalSeparator, CurrencyUnit, CurrencySubunit, KpLeftParen, KpRightParen, KpLeftBrace, KpRightBrace, KpTab, KpBackspace, KpA, KpB, KpC, KpD, KpE, KpF, KpXor, KpPower, KpPercent, KpLess, KpGreater, KpAmpersand, KpDblAmpersand, KpVerticalBar, KpDblverticalbar, KpColon, KpHash, KpSpace, KpAt, KpExclam, KpMemStore, KpMemRecall, KpMemClear, KpMemAdd, KpMemSubtract, KpMemMultiply, KpMemDivide, KpPlusMinus, KpClear, KpClearEntry, KpBinary, KpOctal, KpDecimal, KpHexadecimal, LCtrl, LShift, LAlt, LGui, RCtrl, RShift, RAlt, RGui, Mode, AudionExt, AudioPrev, AudioStop, AudioPlay, AudioMute, MediaSelect, WWW, Mail, Calculator, Computer, AcSearch, AcHome, AcBack, AcForward, AcStop, AcRefresh, AcBookmarks, BrightnessDown, BrightnessUp, DisplaySwitch, KbDIllumToggle, KbDIllumDown, KbDIllumUp, Eject, Sleep]

data KeyMod = ModLShift
            | ModRShift
            | ModLCtrl
            | ModRCtrl
            | ModLAlt
            | ModRAlt
            | ModLGui
            | ModRGui
            | ModNum
            | ModCaps
            | ModMode
            | ModReserved

instance Flag Bits32 KeyMod where
    toFlag ModLShift   = 0x0001
    toFlag ModRShift   = 0x0002
    toFlag ModLCtrl    = 0x0040
    toFlag ModRCtrl    = 0x0080
    toFlag ModLAlt     = 0x0100
    toFlag ModRAlt     = 0x0200
    toFlag ModLGui     = 0x0400
    toFlag ModRGui     = 0x0800
    toFlag ModNum      = 0x1000
    toFlag ModCaps     = 0x2000
    toFlag ModMode     = 0x4000
    toFlag ModReserved = 0x8000

instance Enumerable KeyMod where
    enumerate = [ModLShift, ModRShift, ModLCtrl, ModRCtrl, ModLAlt, ModRAlt, ModLGui, ModRGui, ModNum, ModCaps, ModMode, ModReserved]
