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

int idris_sharedDisplayMode(int displayIndex, int (displayGetter) (int, SDL_DisplayMode*)) {
  return displayGetter(displayIndex, &sharedDisplayMode_mode);
}

int idris_sharedDisplayMode2(int displayIndex, int modeIndex, int (displayGetter) (int, int, SDL_DisplayMode*)) {
  return displayGetter(displayIndex, modeIndex, &sharedDisplayMode_mode);
}

Uint32 idris_sharedDisplayMode_format() {
  return sharedDisplayMode_mode.format;
}

int idris_sharedDisplayMode_w() {
  return sharedDisplayMode_mode.w; 
}

int idris_sharedDisplayMode_h() {
  return sharedDisplayMode_mode.h;
}

int idris_sharedDisplayMode_refresh_rate() {
  return sharedDisplayMode_mode.refresh_rate;
}

void* idris_sharedDisplayMode_driverdata() {
  return sharedDisplayMode_mode.driverdata;
}



int idris_SDL_getDisplayMode(int displayIndex, int modeIndex) {
  return idris_sharedDisplayMode2(displayIndex, modeIndex, SDL_GetDisplayMode);
}

int idris_SDL_getDesktopDisplayMode(int displayIndex) {
  return idris_sharedDisplayMode(displayIndex, SDL_GetDesktopDisplayMode);
}

int idris_SDL_getCurrentDisplayMode(int displayIndex) {
  return idris_sharedDisplayMode(displayIndex, SDL_GetCurrentDisplayMode);
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

