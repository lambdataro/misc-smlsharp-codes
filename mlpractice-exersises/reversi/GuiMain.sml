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
      "SML# Reversi",
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
    game: Game.game,
    clickPos: Game.pos option
  }

val initState =
  {
    isRunning = true,
    game = Game.init,
    clickPos = NONE
  }

val gridSize = 50
val stoneSize = 20
val offsetX = 50
val offsetY = 50
val width = gridSize * Game.boardSize
val height = width

(* イベント処理 *)

fun handleEvents gameState =
  case SDL2.SDL_PollEvent () of
    SOME SDL2.SDL_QUIT => gameState # {isRunning = false}
  | SOME (SDL2.SDL_MOUSEBUTTONDOWN {x, y, button = SDL_BUTTON_LEFT}) =>
    let
      val xIdx =
        if x >= offsetX andalso x <= offsetX + width then
          SOME ((x - offsetX) div gridSize)
        else
          NONE
      val yIdx =
        if y >= offsetY andalso y <= offsetY + height then
          SOME ((y - offsetY) div gridSize)
        else
          NONE
    in
      case (xIdx, yIdx) of
        (SOME xIdx, SOME yIdx) => handleEvents (gameState # {clickPos = SOME (xIdx, yIdx)})
      | _ => handleEvents gameState
    end
  | SOME _ => handleEvents gameState
  | NONE => gameState

(* 状態の更新 *)
fun updateStates gameState =
  let
    val game = #game gameState
    val pos =
      case #next game of
        NONE => NONE
      | SOME Game.WHITE => SOME (Cpu.cpuNext (#board game) Game.WHITE)
      | SOME Game.BLACK =>
        case #clickPos gameState of
          NONE => NONE
        | SOME (x, y) => SOME (x, y)
  in
    case pos of
      NONE => gameState
    | SOME pos =>
      case Game.step game pos of
        NONE => gameState
      | SOME game => gameState # {game = game}
  end

(* 描画処理 *)

fun renderGrid board possible =
  let
    val _ = SDL2.SDL_SetRenderDrawColor (renderer, 0w255, 0w255, 0w255, 0w255)
    val _ = SDL2.SDL_RenderDrawRect (renderer, SOME {x = offsetX, y = offsetY, w = width, h = height})
    val _ = List.app
      (fn (x, y) => 
        let
          val _ = SDL2.SDL_SetRenderDrawColor (renderer, 0w255, 0w255, 0w255, 0w255)
          val _ = SDL2.SDL_RenderDrawRect
            (
              renderer,
              SOME {
                x = offsetX + x * gridSize,
                y = offsetY + y * gridSize,
                w = gridSize,
                h = gridSize
              }
            )
        in
          case (Game.get board (x, y), Game.mem possible (x, y)) of
            (SOME Game.BLACK, _) =>
              SDL2_gfx.filledCircleRGBA
                (
                  renderer,
                  offsetX + x * gridSize + gridSize div 2,
                  offsetY + y * gridSize + gridSize div 2,
                  stoneSize,
                  0w0,
                  0w0,
                  0w0,
                  0w255
                )
          | (SOME Game.WHITE, _) =>
              SDL2_gfx.filledCircleRGBA
                (
                  renderer,
                  offsetX + x * gridSize + gridSize div 2,
                  offsetY + y * gridSize + gridSize div 2,
                  stoneSize,
                  0w255,
                  0w255,
                  0w255,
                  0w255
                )
          | (NONE, false) => ()
          | (NONE, true) =>
              (
                SDL2.SDL_SetRenderDrawColor (renderer, 0w0, 0w96, 0w0, 0w255);
                SDL2.SDL_RenderFillRect
                  (
                    renderer,
                    SOME {
                      x = offsetX + x * gridSize + 1,
                      y = offsetY + y * gridSize + 1,
                      w = gridSize - 2,
                      h = gridSize - 2
                    }
                  )
              )
        end
      )
      Game.allPos
  in
    ()
  end

fun render gameState =
  let
    val _ = SDL2.SDL_SetRenderDrawColor (renderer, 0w0, 0w63, 0w0, 0w255)
    val _ = SDL2.SDL_RenderClear renderer
    val game = #game gameState
    val board = #board game
    val _ =
      case #next game of
        SOME c => renderGrid board (Game.possible board c)
      | NONE => renderGrid board []
  in
    SDL2.SDL_RenderPresent renderer
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
