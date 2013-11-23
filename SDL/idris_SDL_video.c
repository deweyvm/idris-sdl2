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

int idris_SDL_getClosestDisplayMode(int displayIndex, Uint32 format, int w, int h, int refresh_rate, void* driverdata) {
  SDL_DisplayMode mode;
  mode.format = format;
  mode.w = w;
  mode.h = h;
  mode.refresh_rate = refresh_rate;
  mode.driverdata = mode.driverdata;
  SDL_DisplayMode* closest = SDL_GetClosestDisplayMode(displayIndex, &mode, &sharedDisplayMode_mode);
  return closest != NULL;
}

int idris_SDL_SetWindowDisplayMode(SDL_Window* window, Uint32 format, int w, int h, int refresh_rate, void* driverdata) {
  SDL_DisplayMode mode;
  mode.format = format;
  mode.w = w;
  mode.h = h;
  mode.refresh_rate = refresh_rate;
  mode.driverdata = mode.driverdata;
  return SDL_SetWindowDisplayMode(window, &mode);
}


//fixme -- reference to window is lost on the C side, does this matter?
SDL_Window* idris_sharedWindow_window;

SDL_Window* idris_sharedWindow() {
  return idris_sharedWindow_window;
}


int idris_SDL_CreateWindow(const char* title, int x, int y, int w, int h, Uint32 flags) { 
  idris_sharedWindow_window = SDL_CreateWindow(title, x, y, w, h, flags);
  return idris_sharedWindow_window != NULL;
}

int idris_SDL_getWindowDisplayMode(SDL_Window* window) {
  return SDL_GetWindowDisplayMode(window, &sharedDisplayMode_mode);
}

int idris_SDL_createWindowFrom(const void* data) {
  idris_sharedWindow_window = SDL_CreateWindowFrom(data);
  return idris_sharedWindow_window != NULL;
}

int idris_SDL_getWindowFromID(Uint32 id) {
  idris_sharedWindow_window = SDL_GetWindowFromID(id);
  return idris_sharedWindow_window != NULL;
}
