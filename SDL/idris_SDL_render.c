#include "idris_SDL_render.h"

static SDL_Window* window;
static SDL_Renderer* renderer;
SDL_Renderer* idris_sharedRenderer_renderer() {
    return renderer;
}

SDL_Window* idris_sharedWindow_window() {
    return window;
}

int idris_SDL_createWindowAndRenderer(int width, int height, Uint32 flags) {
    return 0 == SDL_CreateWindowAndRenderer(width, height, flags,
                                            &window, &renderer);
}


int idris_SDL_createSoftwareRenderer(SDL_Surface* surface) {
    renderer = SDL_CreateSoftwareRenderer(surface);
    return renderer != NULL;
}

int idris_SDL_getRenderer(SDL_Window* window) {
    renderer = SDL_GetRenderer(window);
    return renderer != NULL;
}

static SDL_RendererInfo rendererInfo;
int idris_SDL_getRendererInfo(SDL_Renderer* renderer) {
    return 0 == SDL_GetRendererInfo(renderer, &rendererInfo);
}

char* idris_rendererInfo_name() {
    return rendererInfo.name;
}

Uint32 idris_rendererInfo_flags() {
    return rendererInfo.flags;
}

int idris_rendererInfo_hasTextureFormat() {
    return rendererInfo.num_texture_formats > 0;
}

Uint32 idris_rendererInfo_getTextureFormat() {
    return rendererInfo.texture_formats[rendererInfo.num_texture_formats---1];
}

int idris_rendererInfo_max_texture_width() {
    return rendererInfo.max_texture_width;
}

int idris_rendererInfo_max_texture_height() {
    return rendererInfo.max_texture_height;
}

static int width;
static int height;

int idris_sharedWidth_int() {
    return width;
}

int idris_sharedHeight_int(){
    return height;
}

int idris_SDL_getRendererOutputSize(SDL_Renderer* renderer) {
    return 0 == SDL_GetRendererOutputSize(renderer, &width, &height);
}

static SDL_Texture* texture;
SDL_Texture* idris_sharedTexture_texture() {
    return texture;
}
int idris_SDL_createTexture(SDL_Renderer* renderer, Uint32 format, int access, int w, int h) {
    texture = SDL_CreateTexture(renderer, format, access, w, h);
    return texture != NULL;
}

int idris_SDL_createTextureFromSurface(SDL_Renderer* renderer, SDL_Surface* surface) {
    texture = SDL_CreateTextureFromSurface(renderer, surface);
    return texture != NULL;
}

static int access;
static Uint32 format;

int getSharedTextureAccess_int();
Uint32 getSharedFormat_int();
int idris_SDL_queryTexture(SDL_Texture * texture) {
    return 0 == SDL_QueryTexture(texture, &format, &access, &width, &height);
}

static Uint8 r;
static Uint8 g;
static Uint8 b;

Uint8 idris_getRed_uint8() {
    return r;
}

Uint8 idris_getGreen_uint8() {
    return g;
}

Uint8 idris_getBlue_uint8(){
    return b;
}

int idris_SDL_getTextureColorMod(SDL_Texture* texture) {
    return 0 == SDL_GetTextureColorMod(texture, &r, &g, &b);
}

static Uint8 a;
int idris_SDL_getTextureAlphaMod(SDL_Texture* texture) {
    return 0 == SDL_GetTextureAlphaMod(texture, &a);
}

SDL_BlendMode blendMode;
SDL_BlendMode idris_getBlendMode_mode() {
    return blendMode;
}

int idris_SDL_getTextureBlendMode(SDL_Texture* texture) {
    return 0 == SDL_GetTextureBlendMode(texture, &blendMode);
}

int idris_SDL_updateTexture(SDL_Texture* texture, int x, int y, int w, int h, const void *pixels, int pitch) {
    SDL_Rect rect = {x, y, w, h};
    return 0 == SDL_UpdateTexture(texture, &rect, pixels, pitch);
}

static void* pixels;
static int pitch;
//extern DECLSPEC int SDLCALL SDL_LockTexture(SDL_Texture * texture, const SDL_Rect * rect, void **pixels, int *pitch);
int idris_SDL_lockTexture(SDL_Texture * texture, int x, int y, int w, int h) {
    SDL_Rect rect = {x, y, w, h};
    return 0 == SDL_LockTexture(texture, &rect, &pixels, &pitch);
}

void* idris_getPixels() {
    return pixels;
}

int idris_getPitch() {
    return pitch;
}

static SDL_Texture* texture;
int idris_SDL_getRenderTarget(SDL_Renderer* renderer) {
    texture = SDL_GetRenderTarget(renderer);
    return texture != NULL;
}
SDL_Texture* idris_sharedTexture() {
    return texture;
}

void idris_SDL_renderGetLogicalSize(SDL_Renderer* renderer) {
    SDL_RenderGetLogicalSize(renderer, &width, &height);
}

int idris_SDL_renderSetViewport(SDL_Renderer* renderer, int x, int y, int w, int h) {
    SDL_Rect rect = {x, y, w, h};
    return 0 == SDL_RenderSetViewport(renderer, &rect);
}

static int x;
static int y;
int idris_render_sharedX_int() {
    return x;
}

int idris_render_sharedY_int() {
    return y;
}

void idris_SDL_renderGetViewport(SDL_Renderer* renderer) {
    SDL_Rect rect;
    SDL_RenderGetViewport(renderer, &rect);
    x = rect.x;
    y = rect.y;
    width = rect.w;
    height = rect.h;
}

int idris_SDL_renderSetClipRect(SDL_Renderer* renderer, int x, int y, int w, int h) {
    SDL_Rect rect = {x, y, w, h};
    return 0 == SDL_RenderSetClipRect(renderer, &rect);
}

void idris_SDL_renderGetClipRect(SDL_Renderer* renderer) {
    SDL_Rect rect;
    SDL_RenderGetClipRect(renderer, &rect);
    x = rect.x;
    y = rect.y;
    width = rect.w;
    height = rect.h;
}

void idris_SDL_renderGetScale(SDL_Renderer* renderer) {
    SDL_RenderGetScale(renderer, &x, &y);
}
