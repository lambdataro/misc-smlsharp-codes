#include <SDL2/SDL.h>

SDL_Rect *stub_CreateRect(int x, int y, int w, int h) {
  SDL_Rect *rect = malloc(sizeof(SDL_Rect));
  if (!rect) return NULL;
   
  rect->x = x;
  rect->y = y;
  rect->w = w;
  rect->h = h;
  
  return rect;
}

void stub_DestroyRect(SDL_Rect *rect) {
  free(rect);
}

const SDL_PixelFormat *SDL_Surface_GetFormat(const SDL_Surface *surface) {
  return surface->format;
}

SDL_Event *stub_SDL_PollEvent() {
  SDL_Event *event = malloc(sizeof(SDL_Event));
  if (!event) return NULL;

  if (!SDL_PollEvent(event)) {
    free(event);
    return NULL;
  }

  return event;
}

void stub_DestroyEvent(SDL_Event *event) {
  free(event);
}

int SDL_Event_GetType(SDL_Event *event) {
  return event->type;
}
