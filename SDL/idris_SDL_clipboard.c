#include "idris_SDL_clipboard.h"

char* getClipboardText_string = NULL;
int idris_SDL_GetClipboardText() {
  getClipboardText_string = SDL_GetClipboardText();
  return getClipboardText_string != NULL;
}

char* idris_SDL_GetClipboardText_string() {
  if (getClipboardText_string == NULL) {
    return "";
  } else {
    return getClipboardText_string;
  }
  
}

void idris_SDL_GetClipboardText_free() {
  SDL_free(getClipboardText_string);
}
