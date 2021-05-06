structure SDL2_ttf =
struct
  (* TTF_Init *)
  val TTF_Init_stub = _import "TTF_Init" : () -> int
  fun TTF_Init () =
    if TTF_Init_stub () = 0 then ()
    else raise SDL2.SDL_Error "TTF_Init error"

  (* TTF_Quit *)
  val TTF_Quit = _import "TTF_Quit" : () -> ()

  (* type TTF_Font *)
  type TTF_Font = unit ptr

  (* TTF_OpenFont *)
  val TTF_OpenFont_stub = _import "TTF_OpenFont" : (string, int) -> TTF_Font
  fun TTF_OpenFont (file, ptsize) =
    let
      val font = TTF_OpenFont_stub (file, ptsize)
    in
      if Pointer.isNull font then
        raise SDL2.SDL_Error (SDL2.SDL_GetError ())
      else 
        font
    end

  (* TTF_CloseFont *)
  val TTF_CloseFont = _import "TTF_CloseFont" : TTF_Font -> ()

  (* TTF_RenderUTF8_Solid *)
  val TTF_RenderUTF8_Solid_wrapper = _import "TTF_RenderUTF8_Solid_wrapper" : (TTF_Font, string, word8, word8, word8, word8) -> SDL2.SDL_Surface
  fun TTF_RenderUTF8_Solid (font, text, {r, g, b, a}) =
    let
      val surface = TTF_RenderUTF8_Solid_wrapper (font, text, r, g, b, a)
    in
      if Pointer.isNull surface then
        raise SDL2.SDL_Error (SDL2.SDL_GetError ())
      else
        surface
    end
end
