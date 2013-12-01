#include "idris_SDL_events.h"

static SDL_Event* event;
int idris_SDL_pollEvent() {
    return 0 == SDL_PollEvent(&event);
}

Uint32 idris_getEventType() {
    return event->type;
}

Uint32 idris_getTimestamp() {
    return event->common.timestamp;
}

Uint32 idris_windowEvent_windowID() {
    return event->window.windowID;
}
Uint8 idris_windowEvent_event() {
    return event->window.event;
}
Uint8 idris_windowEvent_padding1() {
    return event->window.padding1;
}
Uint8 idris_windowEvent_padding2() {
    return event->window.padding2;
}
Uint8 idris_windowEvent_padding3() {
    return event->window.padding3;
}
Sint32 idris_windowEvent_data1() {
    return event->window.data1;
}
Sint32 idris_windowEvent_data2() {
    return event->window.data2;
}

Uint32 idris_keyboardEvent_windowID() {
    return event->key.windowID;
}
Uint8 idris_keyboardEvent_state() {
    return event->key.state;
}
Uint8 idris_keyboardEvent_repeat() {
    return event->key.repeat;
}
Uint8 idris_keyboardEvent_padding2() {
    return event->key.padding2;
}
Uint8 idris_keyboardEvent_padding3() {
    return event->key.padding3;
}
SDL_Keysym idris_keyboardEvent_keysym() {
    return event->key.keysym;
}

Uint32 idris_textEditingEvent_windowID() {
    return event->edit.windowID;
}
char* idris_textEditingEvent_text() {
    return event->edit.text;
}
Sint32 idris_textEditingEvent_start() {
    return event->edit.start;
}
Sint32 idris_textEditingEvent_length() {
    return event->edit.length;
}

Uint32 idris_textInputEvent_windowID() {
    return event->text.windowID;
}
char* idris_textInputEvent_text() {
    return event->text.text;
}

Uint32 idris_mouseMotionEvent_windowID() {
    return event->motion.windowID;
}
Uint32 idris_mouseMotionEvent_which() {
    return event->motion.which;
}
Uint32 idris_mouseMotionEvent_state() {
    return event->motion.state;
}
Sint32 idris_mouseMotionEvent_x() {
    return event->motion.x;
}
Sint32 idris_mouseMotionEvent_y() {
    return event->motion.y;
}
Sint32 idris_mouseMotionEvent_xrel() {
    return event->motion.xrel;
}
Sint32 idris_mouseMotionEvent_yrel() {
    return event->motion.yrel;
}

Uint32 idris_mouseButtonEvent_windowID() {
    return event->button.windowID;
}
Uint32 idris_mouseButtonEvent_which() {
    return event->button.which;
}
Uint8 idris_mouseButtonEvent_button() {
    return event->button.button;
}
Uint8 idris_mouseButtonEvent_state() {
    return event->button.state;
}
Uint8 idris_mouseButtonEvent_padding1() {
    return event->button.padding1;
}
Uint8 idris_mouseButtonEvent_padding2() {
    return event->button.padding2;
}
Sint32 idris_mouseButtonEvent_x() {
    return event->button.x;
}
Sint32 idris_mouseButtonEvent_y() {
    return event->button.y;
}

Uint32 idris_mouseWheelEvent_windowID() {
    return event->wheel.windowID;
}
Uint32 idris_mouseWheelEvent_which() {
    return event->wheel.which;
}
Sint32 idris_mouseWheelEvent_x() {
    return event->wheel.x;
}
Sint32 idris_mouseWheelEvent_y() {
    return event->wheel.y;
}

SDL_JoystickID idris_joyAxisEvent_which() {
    return event->jaxis.which;
}
Uint8 idris_joyAxisEvent_axis() {
    return event->jaxis.axis;
}
Uint8 idris_joyAxisEvent_padding1() {
    return event->jaxis.padding1;
}
Uint8 idris_joyAxisEvent_padding2() {
    return event->jaxis.padding2;
}
Uint8 idris_joyAxisEvent_padding3() {
    return event->jaxis.padding3;
}
Sint32 /*use larger size*/ idris_joyAxisEvent_value() {
    return event->jaxis.value;
}
Uint16 idris_joyAxisEvent_padding4() {
    return event->jaxis.padding4;
}

SDL_JoystickID idris_joyBallEvent_which() {
    return event->jball.which;
}
Uint8 idris_joyBallEvent_ball() {
    return event->jball.ball;
}
Uint8 idris_joyBallEvent_padding1() {
    return event->jball.padding1;
}
Uint8 idris_joyBallEvent_padding2() {
    return event->jball.padding2;
}
Uint8 idris_joyBallEvent_padding3() {
    return event->jball.padding3;
}
Sint32 /*use larger size*/ idris_joyBallEvent_xrel() {
    return event->jball.xrel;
}
Sint32 /*use larger size*/ idris_joyBallEvent_yrel() {
    return event->jball.yrel;
}

SDL_JoystickID idris_joyHatEvent_which() {
    return event->jhat.which;
}
Uint8 idris_joyHatEvent_hat() {
    return event->jhat.hat;
}
Uint8 idris_joyHatEvent_value() {
    return event->jhat.value;
}
Uint8 idris_joyHatEvent_padding1() {
    return event->jhat.padding1;
}
Uint8 idris_joyHatEvent_padding2() {
    return event->jhat.padding2;
}

SDL_JoystickID idris_joyButtonEvent_which() {
    return event->jbutton.which;
}
Uint8 idris_joyButtonEvent_button() {
    return event->jbutton.button;
}
Uint8 idris_joyButtonEvent_state() {
    return event->jbutton.state;
}
Uint8 idris_joyButtonEvent_padding1() {
    return event->jbutton.padding1;
}
Uint8 idris_joyButtonEvent_padding2() {
    return event->jbutton.padding2;
}

Sint32 idris_joyDeviceEvent_which() {
    return event->jdevice.which;
}

SDL_JoystickID idris_controllerAxisEvent_which() {
    return event->caxis.which;
}
Uint8 idris_controllerAxisEvent_axis() {
    return event->caxis.axis;
}
Uint8 idris_controllerAxisEvent_padding1() {
    return event->caxis.padding1;
}
Uint8 idris_controllerAxisEvent_padding2() {
    return event->caxis.padding2;
}
Uint8 idris_controllerAxisEvent_padding3() {
    return event->caxis.padding3;
}
Sint32 /*use larger size*/ idris_controllerAxisEvent_value() {
    return event->caxis.value;
}
Uint16 idris_controllerAxisEvent_padding4() {
    return event->caxis.padding4;
}

SDL_JoystickID idris_controllerButtonEvent_which() {
    return event->cbutton.which;
}
Uint8 idris_controllerButtonEvent_button() {
    return event->cbutton.button;
}
Uint8 idris_controllerButtonEvent_state() {
    return event->cbutton.state;
}
Uint8 idris_controllerButtonEvent_padding1() {
    return event->cbutton.padding1;
}
Uint8 idris_controllerButtonEvent_padding2() {
    return event->cbutton.padding2;
}

Sint32 idris_controllerDeviceEvent_which() {
    return event->cdevice.which;
}

SDL_TouchID idris_touchFingerEvent_touchId() {
    return event->tfinger.touchId;
}
SDL_FingerID idris_touchFingerEvent_fingerId() {
    return event->tfinger.fingerId;
}
float idris_touchFingerEvent_x() {
    return event->tfinger.x;
}
float idris_touchFingerEvent_y() {
    return event->tfinger.y;
}
float idris_touchFingerEvent_dx() {
    return event->tfinger.dx;
}
float idris_touchFingerEvent_dy() {
    return event->tfinger.dy;
}
float idris_touchFingerEvent_pressure() {
    return event->tfinger.pressure;
}

SDL_TouchID idris_multiGestureEvent_touchId() {
    return event->mgesture.touchId;
}
float idris_multiGestureEvent_dTheta() {
    return event->mgesture.dTheta;
}
float idris_multiGestureEvent_dDist() {
    return event->mgesture.dDist;
}
float idris_multiGestureEvent_x() {
    return event->mgesture.x;
}
float idris_multiGestureEvent_y() {
    return event->mgesture.y;
}
Uint16 idris_multiGestureEvent_numFingers() {
    return event->mgesture.numFingers;
}
Uint16 idris_multiGestureEvent_padding() {
    return event->mgesture.padding;
}

SDL_TouchID idris_dollarGestureEvent_touchId() {
    return event->dgesture.touchId;
}
SDL_GestureID idris_dollarGestureEvent_gestureId() {
    return event->dgesture.gestureId;
}
Uint32 idris_dollarGestureEvent_numFingers() {
    return event->dgesture.numFingers;
}
float idris_dollarGestureEvent_error() {
    return event->dgesture.error;
}
float idris_dollarGestureEvent_x() {
    return event->dgesture.x;
}
float idris_dollarGestureEvent_y() {
    return event->dgesture.y;
}

char* idris_dropEvent_file() {
    return event->drop.file;
}

Uint32 idris_userEvent_windowID() {
    return event->user.windowID;
}
Sint32 idris_userEvent_code() {
    return event->user.code;
}
void* idris_userEvent_data1() {
    return event->user.data1;
}
void* idris_userEvent_data2() {
    return event->user.data2;
}

SDL_SysWMmsg* idris_sysWMEvent_msg() {
    return event->syswm.msg;
}
