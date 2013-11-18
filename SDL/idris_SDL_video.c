#include "idris_SDL_video.h"
#include <stdio.h>
SDL_Rect rect;

int idris_SDL_getDisplayX(int index) {
  int retval = SDL_GetDisplayBounds(index, &rect);
  if (retval == 0) {
    return rect.x;
  }
  return 0;
}

int idris_SDL_getDisplayY(int index) {
  int retval = SDL_GetDisplayBounds(index, &rect);
  if (retval == 0) {
    return rect.y;
  }
  return 0;
}

int idris_SDL_getDisplayWidth(int index) {
  int retval = SDL_GetDisplayBounds(index, &rect);
  if (retval == 0) {
    return rect.w;
  }
  return 0;
}

int idris_SDL_getDisplayHeight(int index) {
  int retval = SDL_GetDisplayBounds(index, &rect);
  if (retval == 0) {
    return rect.h;
  }
  return 0;
}
