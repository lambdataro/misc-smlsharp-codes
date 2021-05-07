#include <SDL2/SDL.h>
#include <SDL2/SDL_ttf.h>
#include <SDL2/SDL2_framerate.h>

SDL_Rect *CreateRect(int x, int y, int w, int h) {
  SDL_Rect *rect = malloc(sizeof(SDL_Rect));
  if (!rect) return NULL;
   
  rect->x = x;
  rect->y = y;
  rect->w = w;
  rect->h = h;
  
  return rect;
}

void DestroyRect(SDL_Rect *rect) {
  free(rect);
}

const SDL_PixelFormat *SDL_Surface_GetFormat(const SDL_Surface *surface) {
  return surface->format;
}

SDL_Event *SDL_PollEvent_wrapper() {
  SDL_Event *event = malloc(sizeof(SDL_Event));
  if (!event) return NULL;

  if (!SDL_PollEvent(event)) {
    free(event);
    return NULL;
  }

  return event;
}

void DestroyEvent(SDL_Event *event) {
  free(event);
}

Uint32 SDL_Event_GetType(SDL_Event *event) {
  return event->type;
}

int SDL_MouseMotionEvent_GetX(SDL_Event *event) {
  return event->motion.x;
}

int SDL_MouseMotionEvent_GetY(SDL_Event *event) {
  return event->motion.y;
}

int SDL_MouseButtonEvent_GetX(SDL_Event *event) {
  return event->button.x;
}

int SDL_MouseButtonEvent_GetY(SDL_Event *event) {
  return event->button.y;
}

int SDL_MouseButtonEvent_GetButton(SDL_Event *event) {
  return event->button.button;
}

SDL_Surface *TTF_RenderUTF8_Solid_wrapper(TTF_Font *font, const char *text, Uint8 r, Uint8 g, Uint8 b, Uint8 a) {
  SDL_Color color;
  color.r = r;
  color.g = g;
  color.b = b;
  color.a = a;
  return TTF_RenderUTF8_Solid(font, text, color);
}

FPSmanager *SDL_initFramerate_wrapper() {
  FPSmanager *manager = malloc(sizeof(FPSmanager));
  if (!manager) return NULL;
  SDL_initFramerate(manager);
  return manager;
}

void DestroyFPSManager(FPSmanager *manager) {
  free(manager);
}
