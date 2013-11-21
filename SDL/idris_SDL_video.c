#include "idris_SDL_video.h"

SDL_Rect getDisplayBounds_rect;
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

SDL_DisplayMode sharedDisplayMode_mode;

int idris_SDL_sharedDisplayMode_get(int displayIndex, int (displayGetter) (int, SDL_DisplayMode*)) {
  return displayGetter(displayIndex, &sharedDisplayMode_mode);
}

SDL_DisplayMode getDisplayMode_mode;
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

SDL_DisplayMode getDesktopDisplayMode_mode;
//fixargs
int idris_getDesktopDisplayMode(int displayIndex) {
  return SDL_GetDesktopDisplayMode(displayIndex, &getDesktopDisplayMode_mode);
}
Uint32 idris_getDesktopDisplayMode_format() {
  return getDesktopDisplayMode_mode.format;
}
int idris_getDesktopDisplayMode_w() {
  return getDesktopDisplayMode_mode.w;
}
int idris_getDesktopDisplayMode_h() {
  return getDesktopDisplayMode_mode.h;
}
int idris_getDesktopDisplayMode_refresh_rate() {
  return getDesktopDisplayMode_mode.refresh_rate;
}
void* idris_getDesktopDisplayMode_driverdata() {
  return getDesktopDisplayMode_mode.driverdata;
}

//fixme -- reference to window is lost
static SDL_Window* createWindow_window;
int idris_SDL_CreateWindow(const char* title, int x, int y, int w, int h, Uint32 flags) { 
  //hypothesis -- window is being optimized away?
  createWindow_window = SDL_CreateWindow(title, x, y, w, h, SDL_WINDOW_OPENGL);
  printf("upper window is %08X\n", createWindow_window);
  
  return createWindow_window != NULL;
}

SDL_Window* idris_SDL_CreateWindow_window() {
  printf("lower window is %08X\n", createWindow_window);
  return createWindow_window;
}

