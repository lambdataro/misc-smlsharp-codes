(* SDLの初期化 *)

val _ =
  SDL2.SDL_Init [SDL2.SDL_INIT_VIDEO, SDL2.SDL_INIT_AUDIO]
  handle SDL2.SDL_Error message =>
    (
      SDL2.SDL_Log1 ("SDLの初期化に失敗: %s", message);
      OS.Process.exit OS.Process.failure
    )

val _ = OS.Process.atExit SDL2.SDL_Quit

val _ = SDL2_ttf.TTF_Init ()
  handle SDL2.SDL_Error message =>
    (
      SDL2.SDL_Log1 ("SDL_ttfの初期化に失敗: %s", message);
      OS.Process.exit OS.Process.failure
    )

val _ = OS.Process.atExit SDL2_ttf.TTF_Quit

(* ウインドウの作成 *)

val window =
  SDL2.SDL_CreateWindow
    (
      "SML# SDL2 Test04",
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

(* リソース *)

val font =
  SDL2_ttf.TTF_OpenFont ("font/mplus-1p-heavy.ttf", 48)
  handle SDL2.SDL_Error message =>
    (
      SDL2.SDL_Log1 ("フォントの読み込みに失敗: %s", message);
      OS.Process.exit OS.Process.failure
    )

val textSurface = SDL2_ttf.TTF_RenderUTF8_Solid (font, "SML#とSDL_ttfで文字列を描くテスト", {r = 0w255, g = 0w255, b = 0w255, a = 0w255})
  handle SDL2.SDL_Error message =>
    (
      SDL2.SDL_Log1 ("フォントの描画に失敗: %s", message);
      OS.Process.exit OS.Process.failure
    )

val texture = SDL2.SDL_CreateTextureFromSurface (renderer, textSurface)
val (textureWidth, textureHeight) =
  let
    val {w, h, ...} = SDL2.SDL_QueryTexture texture
  in
    (w, h)
  end

val _ = SDL2.SDL_FreeSurface textSurface
val _ = SDL2_ttf.TTF_CloseFont font

(* ゲームの状態 *)

type gameState =
  {
    isRunning: bool
  }

val initState =
  {
    isRunning = true
  }

(* イベント処理 *)

fun handleEvents gameState =
  case SDL2.SDL_PollEvent () of
    SOME SDL2.SDL_QUIT => gameState # {isRunning = false}
  | _ => gameState

(* 描画処理 *)

fun render gameState =
  let
    val _ = SDL2.SDL_SetRenderDrawColor (renderer, 0w0, 0w0, 0w127, 0w255)
    val _ = SDL2.SDL_RenderClear renderer
    val _ = SDL2.SDL_SetRenderDrawColor (renderer, 0w255, 0w255, 0w255, 0w255)
    val _ = SDL2.SDL_RenderCopy
      (
        renderer,
        texture,
        NONE,
        SOME {
          x = (1280 - textureWidth) div 2,
          y = (960 - textureHeight) div 2,
          w = textureWidth,
          h = textureHeight
        }
      )
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
