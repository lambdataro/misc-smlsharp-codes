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
      "SML# SDL2 Test02",
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

(* レンダラの作成 *)

val renderer =
  SDL2.SDL_CreateRenderer (window, ~1, [])

val _ = OS.Process.atExit (fn () => SDL2.SDL_DestroyRenderer renderer)

(* ゲームの状態 *)

val gameIsRunning = ref true

(* イベント処理 *)

fun handleEvents () =
  case SDL2.SDL_PollEvent () of
    SOME SDL2.SDL_QUIT => gameIsRunning := false
  | _ => ()

(* 描画処理 *)

fun render () =
  let
    val _ = SDL2.SDL_SetRenderDrawColor (renderer, 0w0, 0w0, 0w127, 0w255)
    val _ = SDL2.SDL_RenderClear renderer
    val _ = SDL2.SDL_SetRenderDrawColor (renderer, 0w255, 0w255, 0w255, 0w255)
    val _ = SDL2.SDL_RenderDrawLine (renderer, 0, 0, 1280, 960)
    val _ = SDL2.SDL_RenderDrawLine (renderer, 0, 960, 1280, 0)
    val _ = SDL2.SDL_RenderDrawRect (renderer, SOME {x = 50, y = 50, w = 50, h = 50})
    val _ = SDL2.SDL_RenderFillRect (renderer, SOME {x = 150, y = 50, w = 50, h = 50})
    val _ = SDL2.SDL_RenderDrawPoint (renderer, 50, 150)
    val _ = SDL2.SDL_RenderDrawPoint (renderer, 100, 150)
    val _ = SDL2.SDL_RenderDrawPoint (renderer, 50, 200)
    val _ = SDL2.SDL_RenderDrawPoint (renderer, 100, 200)
    val _ = SDL2.SDL_RenderPresent renderer
  in
    ()
  end

(* イベントループ *)

fun eventLoop () =
  if !gameIsRunning then
    (
      handleEvents ();
      render ();
      eventLoop ()
    )
  else ()

val _ =
  eventLoop ()
  handle SDL2.SDL_Error message =>
    (
      SDL2.SDL_Log message;
      OS.Process.exit OS.Process.failure
    )
