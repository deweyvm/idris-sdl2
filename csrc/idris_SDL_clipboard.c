#include "idris_SDL_clipboard.h"

static char* getClipboardText_string = NULL;
int idris_SDL_getClipboardText() {
    getClipboardText_string = SDL_GetClipboardText();
    return getClipboardText_string != NULL;
}

char* idris_SDL_getClipboardText_string() {
    if (getClipboardText_string == NULL) {
        return "";
    } else {
        return getClipboardText_string;
    }

}

void idris_SDL_getClipboardText_free() {
    SDL_free(getClipboardText_string);
}
