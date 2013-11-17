#include "idris_SDL_video.h"

void myglBegin() {
  glBegin(GL_TRIANGLES);
}

const char* mySDL_Init() {
  SDL_Init(SDL_INIT_EVERYTHING);
  const char* result = SDL_GetError();
  return result;
}

void mySDL_Quit() {
  SDL_Quit();
}

const char* mySDL_GetPlatform() {
  return SDL_GetPlatform();
}

SDL_Window* mySDL_CreateWindow() {
  SDL_Window* window = SDL_CreateWindow("title",
					SDL_WINDOWPOS_UNDEFINED, 
					SDL_WINDOWPOS_UNDEFINED,
					640,
					480,
					SDL_WINDOW_OPENGL);
  if (window == NULL) {
    printf("oops\n");
    exit(1);
  }
  return window;
}

void mySDL_SetWindowPosition(SDL_Window* window, int x, int y) {
  SDL_SetWindowPosition(window, x, y);
}

void mySDL_Delay(int t) {
  SDL_Delay(t);
}
