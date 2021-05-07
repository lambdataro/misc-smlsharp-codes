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
      "SML# SDL2 Test03",
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

type line =
  {
    x1: int,
    y1: int,
    x2: int,
    y2: int
  }


type gameState =
  {
    isRunning: bool,
    dragging: line option,
    lines: line list
  }

val initState =
  {
    isRunning = true,
    dragging = NONE,
    lines = []
  }

(* イベント処理 *)

fun buttonToString button =
  case button of
    SDL2.SDL_BUTTON_LEFT => "LEFT"
  | SDL2.SDL_BUTTON_MIDDLE => "MIDDLE"
  | SDL2.SDL_BUTTON_RIGHT => "RIGHT"
  | SDL2.SDL_BUTTON_X1 => "X1"
  | SDL2.SDL_BUTTON_X2 => "X2"

fun handleEvents gameState =
  case SDL2.SDL_PollEvent () of
    SOME SDL2.SDL_QUIT => gameState # {isRunning = false}
  | SOME (SDL2.SDL_MOUSEMOTION {x, y}) =>
    handleEvents (
      SDL2.SDL_Log2 ("SDL_MOUSEMOTION: (%s, %s)\n", Int.toString x, Int.toString y);
      case #dragging gameState of
        NONE => gameState
      | SOME {x1, y1, x2, y2} => gameState # {dragging = SOME {x1 = x1, y1 = y1, x2 = x, y2 = y}}
    )
  | SOME (SDL2.SDL_MOUSEBUTTONDOWN {x, y, button}) =>
    handleEvents (
      SDL2.SDL_Log3 ("SDL_MOUSEBUTTONDOWN: (%s, %s, %s)\n", buttonToString button, Int.toString x, Int.toString y);
      gameState # {dragging = SOME {x1 = x, y1 = y, x2 = x, y2 = y}}
    )
  | SOME (SDL2.SDL_MOUSEBUTTONUP {x, y, button}) =>
    handleEvents (
      SDL2.SDL_Log3 ("SDL_MOUSEBUTTONUP: (%s, %s, %s)\n", buttonToString button, Int.toString x, Int.toString y);
      case #dragging gameState of
        NONE => gameState
      | SOME line => gameState # {dragging = NONE, lines = line :: #lines gameState}
    )
  | _ => gameState

(* 描画処理 *)

fun render gameState =
  let
    val _ = SDL2.SDL_SetRenderDrawColor (renderer, 0w0, 0w0, 0w127, 0w255)
    val _ = SDL2.SDL_RenderClear renderer
    val _ = SDL2.SDL_SetRenderDrawColor (renderer, 0w255, 0w255, 0w255, 0w255)
    val _ = List.app
      (fn {x1, y1, x2, y2} => SDL2.SDL_RenderDrawLine (renderer, x1, y1, x2, y2))
      (#lines gameState)
    val _ = SDL2.SDL_SetRenderDrawColor (renderer, 0w255, 0w0, 0w0, 0w255)
    val _ = case #dragging gameState of
        NONE => ()
      | SOME {x1, y1, x2, y2} => SDL2.SDL_RenderDrawLine (renderer, x1, y1, x2, y2)
    val _ = SDL2.SDL_RenderPresent renderer
  in
    ()
  end

(* イベントループ *)

fun eventLoop gameState =
  if #isRunning gameState then
    let
      val gameState2 = handleEvents gameState
      val _ = render gameState2
    in
      eventLoop gameState2
    end
  else ()

val _ =
  eventLoop initState
  handle SDL2.SDL_Error message =>
    (
      SDL2.SDL_Log message;
      OS.Process.exit OS.Process.failure
    )
