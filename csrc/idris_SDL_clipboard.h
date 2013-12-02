#ifndef IDRIS_SDL_CLIPBOARD_H
#define IDRIS_SDL_CLIPBOARD_H

#include "SDL2/SDL_clipboard.h"
#include "SDL2/SDL_stdinc.h"

int idris_SDL_getClipboardText();
char* idris_SDL_getClipboardText_string();
void idris_SDL_getClipboardText_free();

#endif /* IDRIS_SDL_CLIPBOARD_H */
