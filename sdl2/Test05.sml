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

val windowWidth = 1280
val windowHeight = 960

val window =
  SDL2.SDL_CreateWindow
    (
      "SML# SDL2 Test05",
      SDL2.SDL_WINDOWPOS_CENTERED,
      SDL2.SDL_WINDOWPOS_CENTERED,
      windowWidth,
      windowHeight,
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

val manager = SDL2_gfx.SDL_initFramerate ()
val _ = SDL2_gfx.SDL_setFramerate (manager, 0w30)

type gameState =
  {
    isRunning: bool,
    ballX: int,
    ballY: int,
    ballVx: int,
    ballVy: int
  }

val initState =
  {
    isRunning = true,
    ballX = windowWidth div 2,
    ballY = windowHeight div 2,
    ballVx = 8,
    ballVy = 8
  }

(* イベント処理 *)

fun handleEvents gameState =
  case SDL2.SDL_PollEvent () of
    SOME SDL2.SDL_QUIT => gameState # {isRunning = false}
  | SOME _ => handleEvents gameState
  | NONE => gameState

(* 状態の更新 *)
fun updateStates gameState =
  let
    val (ballX, ballVx) =
      let
        val newBallX = #ballX gameState + #ballVx gameState
      in
        if newBallX >= windowWidth then (windowWidth - 1, ~(#ballVx gameState))
        else if newBallX < 0 then (0, ~(#ballVx gameState))
        else (newBallX, #ballVx gameState)
      end
    val (ballY, ballVy) =
      let
        val newBallY = #ballY gameState + #ballVy gameState
      in
        if newBallY >= windowHeight then (windowHeight - 1, ~(#ballVy gameState))
        else if newBallY < 0 then (0, ~(#ballVy gameState))
        else (newBallY, #ballVy gameState)
      end
  in
    gameState # {
      ballX = ballX,
      ballY = ballY,
      ballVx = ballVx,
      ballVy = ballVy
    }
  end

(* 描画処理 *)

fun render gameState =
  let
    val _ = SDL2.SDL_SetRenderDrawColor (renderer, 0w0, 0w0, 0w127, 0w255)
    val _ = SDL2.SDL_RenderClear renderer
    val _ = SDL2_gfx.filledCircleRGBA (renderer, #ballX gameState, #ballY gameState, 10, 0w255, 0w255, 0w255, 0w255)
    val _ = SDL2.SDL_RenderPresent renderer
  in
    ()
  end

(* イベントループ *)

fun eventLoop gameState =
  if #isRunning gameState then
    let
      val _ = SDL2_gfx.SDL_framerateDelay manager
      val gameState2 = handleEvents gameState
      val gameState3 = updateStates gameState2
      val _ = render gameState3
    in
      eventLoop gameState3
    end
  else ()

val _ =
  eventLoop initState
  handle SDL2.SDL_Error message =>
    (
      SDL2.SDL_Log message;
      OS.Process.exit OS.Process.failure
    )
