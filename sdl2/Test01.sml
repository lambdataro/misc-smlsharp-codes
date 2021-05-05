(* SDLの初期化 *)

val _ =
  SDL2.SDL_Init [SDL2.SDL_INIT_VIDEO, SDL2.SDL_INIT_AUDIO]
  handle SDL2.SDL_Error message =>
    (
      SDL2.SDL_Log1 ("SDLの初期化に失敗: %s", message);
      OS.Process.exit OS.Process.failure
    )

val _ = OS.Process.atExit SDL2.SDL_Quit

(* ウインドウの作成 *)

val window =
  SDL2.SDL_CreateWindow
    (
      "SML# SDL2 Test01",
      SDL2.SDL_WINDOWPOS_CENTERED,
      SDL2.SDL_WINDOWPOS_CENTERED,
      1280,
      960,
      [SDL2.SDL_WINDOW_SHOWN]
    )
  handle SDL2.SDL_Error message =>
    (
      SDL2.SDL_Log1 ("ウインドウの作成に失敗: %s", message);
      OS.Process.exit OS.Process.failure
    )

val _ = OS.Process.atExit (fn () => SDL2.SDL_DestroyWindow window)

(* 画面を塗りつぶす *)

val surface = SDL2.SDL_GetWindowSurface window
val color = SDL2.SDL_MapRGB
  (
    SDL2.SDL_Surface_GetFormat surface,
    0w0,
    0w0,
    0w127
  )
val _ =SDL2.SDL_FillRect (surface, NONE, color)

val _ = SDL2.SDL_UpdateWindowSurface window

(* イベントループ *)

fun eventLoop () =
  case SDL2.SDL_PollEvent () of
    SOME SDL2.SDL_QUIT => ()
  | _ => eventLoop ()


val _ = eventLoop ()
