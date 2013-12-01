#ifndef IDRIS_SDL_EVENTS_H
#define IDRIS_SDL_EVENTS_H

#include "SDL2/SDL_events.h"

int idris_SDL_pollEvent();
Uint32 idris_getEventType();

Uint32 idris_getTimestamp();

Uint32 idris_windowEvent_windowID();
Uint8 idris_windowEvent_event();
Uint8 idris_windowEvent_padding1();
Uint8 idris_windowEvent_padding2();
Uint8 idris_windowEvent_padding3();
Sint32 idris_windowEvent_data1();
Sint32 idris_windowEvent_data2();

Uint32 idris_keyboardEvent_windowID();
Uint8 idris_keyboardEvent_state();
Uint8 idris_keyboardEvent_repeat();
Uint8 idris_keyboardEvent_padding2();
Uint8 idris_keyboardEvent_padding3();
SDL_Keysym idris_keyboardEvent_keysym();

Uint32 idris_textEditingEvent_windowID();
char* idris_textEditingEvent_text();
Sint32 idris_textEditingEvent_start();
Sint32 idris_textEditingEvent_length();

Uint32 idris_textInputEvent_windowID();
char* idris_textInputEvent_text();

Uint32 idris_mouseMotionEvent_windowID();
Uint32 idris_mouseMotionEvent_which();
Uint32 idris_mouseMotionEvent_state();
Sint32 idris_mouseMotionEvent_x();
Sint32 idris_mouseMotionEvent_y();
Sint32 idris_mouseMotionEvent_xrel();
Sint32 idris_mouseMotionEvent_yrel();

Uint32 idris_mouseButtonEvent_windowID();
Uint32 idris_mouseButtonEvent_which();
Uint8 idris_mouseButtonEvent_button();
Uint8 idris_mouseButtonEvent_state();
Uint8 idris_mouseButtonEvent_padding1();
Uint8 idris_mouseButtonEvent_padding2();
Sint32 idris_mouseButtonEvent_x();
Sint32 idris_mouseButtonEvent_y();

Uint32 idris_mouseWheelEvent_windowID();
Uint32 idris_mouseWheelEvent_which();
Sint32 idris_mouseWheelEvent_x();
Sint32 idris_mouseWheelEvent_y();

SDL_JoystickID idris_joyAxisEvent_which();
Uint8 idris_joyAxisEvent_axis();
Uint8 idris_joyAxisEvent_padding1();
Uint8 idris_joyAxisEvent_padding2();
Uint8 idris_joyAxisEvent_padding3();
Sint32 /*use larger size*/ idris_joyAxisEvent_value();
Uint16 idris_joyAxisEvent_padding4();

SDL_JoystickID idris_joyBallEvent_which();
Uint8 idris_joyBallEvent_ball();
Uint8 idris_joyBallEvent_padding1();
Uint8 idris_joyBallEvent_padding2();
Uint8 idris_joyBallEvent_padding3();
Sint32 /*use larger size*/ idris_joyBallEvent_xrel();
Sint32 /*use larger size*/ idris_joyBallEvent_yrel();

SDL_JoystickID idris_joyHatEvent_which();
Uint8 idris_joyHatEvent_hat();
Uint8 idris_joyHatEvent_value();
Uint8 idris_joyHatEvent_padding1();
Uint8 idris_joyHatEvent_padding2();

SDL_JoystickID idris_joyButtonEvent_which();
Uint8 idris_joyButtonEvent_button();
Uint8 idris_joyButtonEvent_state();
Uint8 idris_joyButtonEvent_padding1();
Uint8 idris_joyButtonEvent_padding2();

Sint32 idris_joyDeviceEvent_which();

SDL_JoystickID idris_controllerAxisEvent_which();
Uint8 idris_controllerAxisEvent_axis();
Uint8 idris_controllerAxisEvent_padding1();
Uint8 idris_controllerAxisEvent_padding2();
Uint8 idris_controllerAxisEvent_padding3();
Sint32 /*use larger size*/ idris_controllerAxisEvent_value();
Uint16 idris_controllerAxisEvent_padding4();

SDL_JoystickID idris_controllerButtonEvent_which();
Uint8 idris_controllerButtonEvent_button();
Uint8 idris_controllerButtonEvent_state();
Uint8 idris_controllerButtonEvent_padding1();
Uint8 idris_controllerButtonEvent_padding2();

Sint32 idris_controllerDeviceEvent_which();

SDL_TouchID idris_touchFingerEvent_touchId();
SDL_FingerID idris_touchFingerEvent_fingerId();
float idris_touchFingerEvent_x();
float idris_touchFingerEvent_y();
float idris_touchFingerEvent_dx();
float idris_touchFingerEvent_dy();
float idris_touchFingerEvent_pressure();

SDL_TouchID idris_multiGestureEvent_touchId();
float idris_multiGestureEvent_dTheta();
float idris_multiGestureEvent_dDist();
float idris_multiGestureEvent_x();
float idris_multiGestureEvent_y();
Uint16 idris_multiGestureEvent_numFingers();
Uint16 idris_multiGestureEvent_padding();

SDL_TouchID idris_dollarGestureEvent_touchId();
SDL_GestureID idris_dollarGestureEvent_gestureId();
Uint32 idris_dollarGestureEvent_numFingers();
float idris_dollarGestureEvent_error();
float idris_dollarGestureEvent_x();
float idris_dollarGestureEvent_y();

char* idris_dropEvent_file();

Uint32 idris_userEvent_windowID();
Sint32 idris_userEvent_code();
void* idris_userEvent_data1();
void* idris_userEvent_data2();

SDL_SysWMmsg* idris_sysWMEvent_msg();


#endif /* IDRIS_SDL_EVENTS_H */
