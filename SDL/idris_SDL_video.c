#include "idris_SDL_video.h"

SDL_Rect getDisplayBounds_rect;
int getDisplayBounds_retval;
int idris_SDL_getDisplayBounds(int index) {
  return SDL_GetDisplayBounds(index, &getDisplayBounds_rect);
}

int idris_SDL_getDisplayBounds_x() {
  return getDisplayBounds_rect.x;
}

int idris_SDL_getDisplayBounds_y() {
  return getDisplayBounds_rect.y;
}

int idris_SDL_getDisplayBounds_w() {
  return getDisplayBounds_rect.w;  
}

int idris_SDL_getDisplayBounds_h() {
  return getDisplayBounds_rect.h;
}


SDL_DisplayMode getDisplayMode_mode;
int getDisplayMode_retval;
int idris_SDL_getDisplayMode(int displayIndex, int modeIndex) {
  return SDL_GetDisplayMode(displayIndex, modeIndex, &getDisplayMode_mode);
}

Uint32 idris_SDL_getDisplayMode_format() {
  return getDisplayMode_mode.format;
}

int idris_SDL_getDisplayMode_w() {
  return getDisplayMode_mode.w;
}

int idris_SDL_getDisplayMode_h() {
  return getDisplayMode_mode.h;
}

int idris_SDL_getDisplayMode_refresh_rate() {
  return getDisplayMode_mode.refresh_rate;
}

void* idris_SDL_getDisplayMode_driverdata() {
  return getDisplayMode_mode.driverdata;
}
