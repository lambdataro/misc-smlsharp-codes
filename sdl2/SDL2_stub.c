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

SDL_Rect *stub_DestroyRect(SDL_Rect *rect) {
  free(rect);
}

const SDL_PixelFormat *SDL_Surface_GetFormat(const SDL_Surface *surface) {
  return surface->format;
}
