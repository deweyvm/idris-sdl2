#ifndef IDRIS_SDL_VIDEO_H
#define IDRIS_SDL_VIDEO_H

#include "SDL2/SDL_rect.h"
#include "SDL2/SDL_video.h"

int idris_SDL_getDisplayBounds(int index);
int idris_SDL_getDisplayBounds_x();
int idris_SDL_getDisplayBounds_y();
int idris_SDL_getDisplayBounds_w();
int idris_SDL_getDisplayBounds_h();

int idris_SDL_getDisplayMode(int displayIndex, int modeIndex);
Uint32 idris_SDL_getDisplayMode_format();
int idris_SDL_getDisplayMode_w();
int idris_SDL_getDisplayMode_h();
int idris_SDL_getDisplayMode_refresh_rate();
void* idris_SDL_getDisplayMode_driverdata();


#endif /*IDRIS_SDL_VIDEO_H*/
