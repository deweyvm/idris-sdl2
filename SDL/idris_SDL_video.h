#ifndef IDRIS_SDL_VIDEO_H
#define IDRIS_SDL_VIDEO_H

#include "SDL2/SDL_rect.h"
#include "SDL2/SDL_video.h"

int idris_SDL_getDisplayBounds(int index);
int idris_SDL_getDisplayBounds_x();
int idris_SDL_getDisplayBounds_y();
int idris_SDL_getDisplayBounds_w();
int idris_SDL_getDisplayBounds_h();

int idris_sharedDisplayMode(int displayIndex, int (displayGetter) (int, SDL_DisplayMode*));
int idris_sharedDisplayMode2(int displayIndex, int modeIndex, int(displayGEtter)(int, int, SDL_DisplayMode*));
Uint32 idris_sharedDisplayMode_format();
int idris_sharedDisplayMode_w();
int idris_sharedDisplayMode_h();
int idris_sharedDisplayMode_refresh_rate();
void* idris_sharedDisplayMode_driverdata();

int idris_SDL_getDisplayMode(int displayIndex, int modeIndex);
int idris_SDL_getDesktopDisplayMode(int displayIndex);
int idris_SDL_getCurrentDisplayMode(int displayIndex);
int idris_SDL_getClosestDisplayMode(int displayIndex, Uint32 format, int w, int h, int refresh_rate, void* driverdata);

int idris_SDL_SetWindowDisplayMode(SDL_Window* window, Uint32 format, int w, int h, int refresh_rate, void* driverdata);

SDL_Window* idris_sharedWindow();

int idris_SDL_CreateWindow(const char* title, int x, int y, int w, int h, Uint32 flags);

int idris_SDL_getWindowDisplayMode(SDL_Window* window);

int idris_SDL_createWindowFrom(const void* data);

int idris_SDL_getWindowFromID(Uint32 id);

//shared across all functions in video which output (only) two int params
int idris_getShared_x();
int idris_getShared_y();

void idris_SDL_getWindowPosition(SDL_Window* window);
void idris_SDL_getWindowSize(SDL_Window* window);
void idris_SDL_getWindowMinimumSize(SDL_Window* window);
void idris_SDL_getWindowMaximumSize(SDL_Window* window);

int idris_SDL_getWindowSurface(SDL_Window* window);
SDL_Surface* idris_SDL_getWindwoSurface_surface();
#endif /*IDRIS_SDL_VIDEO_H*/
