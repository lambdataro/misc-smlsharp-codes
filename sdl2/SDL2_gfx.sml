structure SDL2_gfx =
struct
  val circleRGBA_stub = _import "circleRGBA" : (SDL2.SDL_Renderer, int, int, int, word8, word8, word8, word8) -> int
  fun circleRGBA (renderer, x, y, rad, r, g, b, a) =
    if circleRGBA_stub (renderer, x, y, rad, r, g, b, a) = 0 then ()
    else raise SDL2.SDL_Error (SDL2.SDL_GetError ())

  val filledCircleRGBA_stub = _import "filledCircleRGBA" : (SDL2.SDL_Renderer, int, int, int, word8, word8, word8, word8) -> int
  fun filledCircleRGBA (renderer, x, y, rad, r, g, b, a) =
    if filledCircleRGBA_stub (renderer, x, y, rad, r, g, b, a) = 0 then ()
    else raise SDL2.SDL_Error (SDL2.SDL_GetError ())

  val ellipseRGBA_stub = _import "ellipseRGBA" : (SDL2.SDL_Renderer, int, int, int, int, word8, word8, word8, word8) -> int
  fun ellipseRGBA (renderer, x, y, rx, ry, r, g, b, a) =
    if ellipseRGBA_stub (renderer, x, y, rx, ry, r, g, b, a) = 0 then ()
    else raise SDL2.SDL_Error (SDL2.SDL_GetError ())

  val filledEllipseRGBA_stub = _import "filledEllipseRGBA" :  (SDL2.SDL_Renderer, int, int, int, int, word8, word8, word8, word8) -> int
  fun filledEllipseRGBA (renderer, x, y, rx, ry, r, g, b, a) =
    if filledEllipseRGBA_stub (renderer, x, y, rx, ry, r, g, b, a) = 0 then ()
    else raise SDL2.SDL_Error (SDL2.SDL_GetError ())

  type FPSmanager = unit ptr

  val SDL_initFramerate_wrapper = _import "SDL_initFramerate_wrapper" : () -> FPSmanager
  fun SDL_initFramerate () =
    let
      val manager = SDL_initFramerate_wrapper ()
    in
      if Pointer.isNull manager then
        raise SDL2.SDL_Error "failed to initialize FPSmanager"
      else
        manager
    end
  
  val DestroyFPSManager = _import "DestroyFPSManager" : FPSmanager -> ()

  val SDL_setFramerate_wrapper = _import "SDL_setFramerate" : (FPSmanager, word32) -> int
  fun SDL_setFramerate (manager, fps) =
    if SDL_setFramerate_wrapper (manager, fps) = 0 then
      ()
    else
      raise SDL2.SDL_Error "failed to set framerate"

  val SDL_framerateDelay = _import "SDL_framerateDelay" : FPSmanager -> word32
end
