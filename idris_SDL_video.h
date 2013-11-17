#include "SDL2/SDL.h"
#include "SDL2/SDL_system.h"
#include "SDL2/SDL_opengl.h"

void myglBegin();
const char* mySDL_Init();
void mySDL_Quit();
const char* mySDL_GetPlatform();
SDL_Window* mySDL_CreateWindow();
void mySDL_SetWindowPosition(SDL_Window* window, int x, int y);
void mySDL_Delay(int t);
