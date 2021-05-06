structure SDL2 =
struct
  (* SDLの例外 *)
  exception SDL_Error of string

  (* SDL_GetError *)
  val SDL_GetError_stub = _import "SDL_GetError" : () -> char ptr
  fun SDL_GetError () =
    Pointer.importString (SDL_GetError_stub ())

  fun checkSuccess result =
    if result = 0
    then ()
    else raise (SDL_Error (SDL_GetError ()))

  (* SDL_Init *)
  datatype SDL_InitFlags =
      SDL_INIT_TIMER
    | SDL_INIT_AUDIO
    | SDL_INIT_VIDEO
    | SDL_INIT_JOYSTICK
    | SDL_INIT_HAPTIC
    | SDL_INIT_GAMECONTROLLER
    | SDL_INIT_EVENTS
    | SDL_INIT_SENSOR
    | SDL_INIT_NOPARACHUTE
    | SDL_INIT_EVERYTHING

  val SDL_Init_stub = _import "SDL_Init" : word32 -> int
  fun SDL_Init flags =
    let
      val flags =
        foldl Word32.orb 0wx0
          (
            map
              (fn SDL_INIT_TIMER => 0wx00000001
                | SDL_INIT_AUDIO => 0wx00000010
                | SDL_INIT_VIDEO => 0wx00000020
                | SDL_INIT_JOYSTICK => 0wx00000200
                | SDL_INIT_HAPTIC => 0wx00001000
                | SDL_INIT_GAMECONTROLLER => 0wx00002000
                | SDL_INIT_EVENTS => 0wx00004000
                | SDL_INIT_SENSOR => 0wx00008000
                | SDL_INIT_NOPARACHUTE => 0wx00100000
                | SDL_INIT_EVERYTHING => 0wx0000f231
              )
              flags
          )
    in
      checkSuccess (SDL_Init_stub flags)
    end

  (* SDL_Log *)
  val SDL_Log = _import "SDL_Log" : string -> ()
  val 'a#boxed SDL_Log1 = _import "SDL_Log" : (string, ...('a)) -> ()
  val ('a#boxed, 'b#boxed) SDL_Log2 = _import "SDL_Log" : (string, ...('a, 'b)) -> ()
  val ('a#boxed, 'b#boxed, 'c#boxed) SDL_Log3 = _import "SDL_Log" : (string, ...('a, 'b, 'c)) -> ()

  (* SDL_Quit *)
  val SDL_Quit = _import "SDL_Quit" : () -> ()

  (* SDL_Window *)
  type SDL_Window = unit ptr

  (* SDL_CreateWindow *)
  datatype SDL_WindowFlags =
      SDL_WINDOW_FULLSCREEN
    | SDL_WINDOW_OPENGL
    | SDL_WINDOW_SHOWN
    | SDL_WINDOW_HIDDEN
    | SDL_WINDOW_BORDERLESS
    | SDL_WINDOW_RESIZABLE
    | SDL_WINDOW_MINIMIZED
    | SDL_WINDOW_MAXIMIZED
    | SDL_WINDOW_INPUT_GRABBED
    | SDL_WINDOW_INPUT_FOCUS
    | SDL_WINDOW_MOUSE_FOCUS
    | SDL_WINDOW_FULLSCREEN_DESKTOP
    | SDL_WINDOW_FOREIGN
    | SDL_WINDOW_ALLOW_HIGHDPI
    | SDL_WINDOW_MOUSE_CAPTURE
    | SDL_WINDOW_ALWAYS_ON_TOP
    | SDL_WINDOW_SKIP_TASKBAR
    | SDL_WINDOW_UTILITY
    | SDL_WINDOW_TOOLTIP
    | SDL_WINDOW_POPUP_MENU
    | SDL_WINDOW_VULKAN
    | SDL_WINDOW_METAL

  val SDL_WINDOWPOS_UNDEFINED = 0x1FFF0000
  val SDL_WINDOWPOS_CENTERED = 0x2FFF0000

  val SDL_CreateWindow_stub = _import "SDL_CreateWindow" : (string, int, int, int, int, word32) -> SDL_Window
  fun SDL_CreateWindow (title, x, y, w, h, flags) =
    let
      val flags =
        foldl Word32.orb 0wx0
          (
            map
              (fn SDL_WINDOW_FULLSCREEN => 0wx00000001
                | SDL_WINDOW_OPENGL => 0wx00000002
                | SDL_WINDOW_SHOWN => 0wx00000004
                | SDL_WINDOW_HIDDEN => 0wx00000008
                | SDL_WINDOW_BORDERLESS => 0wx00000010
                | SDL_WINDOW_RESIZABLE => 0wx00000020
                | SDL_WINDOW_MINIMIZED => 0wx00000040
                | SDL_WINDOW_MAXIMIZED => 0wx00000080
                | SDL_WINDOW_INPUT_GRABBED => 0wx00000100
                | SDL_WINDOW_INPUT_FOCUS => 0wx00000200
                | SDL_WINDOW_MOUSE_FOCUS => 0wx00000400
                | SDL_WINDOW_FULLSCREEN_DESKTOP => 0wx00001001
                | SDL_WINDOW_FOREIGN => 0wx00000800
                | SDL_WINDOW_ALLOW_HIGHDPI => 0wx00002000
                | SDL_WINDOW_MOUSE_CAPTURE => 0wx00004000
                | SDL_WINDOW_ALWAYS_ON_TOP => 0wx00008000
                | SDL_WINDOW_SKIP_TASKBAR => 0wx00010000
                | SDL_WINDOW_UTILITY => 0wx00020000
                | SDL_WINDOW_TOOLTIP => 0wx00040000
                | SDL_WINDOW_POPUP_MENU => 0wx00080000
                | SDL_WINDOW_VULKAN => 0wx10000000
                | SDL_WINDOW_METAL => 0wx20000000
              )
              flags
          )
      val window = SDL_CreateWindow_stub (title, x, y, w, h, flags)
    in
      if Pointer.isNull window
      then
        raise (SDL_Error (SDL_GetError ()))
      else
        window
    end

  (* SDL_DestroyWindow *)
  val SDL_DestroyWindow = _import "SDL_DestroyWindow" : SDL_Window -> ()

  (* SDL_Delay *)
  val SDL_Delay = _import "SDL_Delay" : word32 -> ()

  (* SDL_Surface *)
  type SDL_Surface = unit ptr
  type SDL_PixelFormat = unit ptr
  val SDL_Surface_GetFormat = _import "SDL_Surface_GetFormat" : SDL_Surface -> SDL_PixelFormat

  (* SDL_GetWindowSurface *)
  val SDL_GetWindowSurface_stub = _import "SDL_GetWindowSurface" : SDL_Window -> SDL_Surface
  fun SDL_GetWindowSurface window =
    let
      val surface = SDL_GetWindowSurface_stub window
    in
      if Pointer.isNull window
      then
        raise (SDL_Error (SDL_GetError ()))
      else
        surface
    end

  (* SDL_Rect *)
  type SDL_Rect_c = unit ptr
  val stub_CreateRect = _import "stub_CreateRect" : (int, int, int, int) -> SDL_Rect_c
  val stub_DestroyRect = _import "stub_DestroyRect" : SDL_Rect_c -> ()

  type SDL_Rect =
    {
      x: int,
      y: int,
      w: int,
      h: int
    }

  fun convert_SDL_Rect rectOpt =
    case rectOpt of
      NONE => Pointer.NULL ()
    | SOME {x, y, w, h} => stub_CreateRect (x, y, w, h)

  (* SDL_FillRect *)
  val SDL_FillRect_stub = _import "SDL_FillRect" : (SDL_Surface, SDL_Rect_c, word32) -> int
  fun SDL_FillRect (surface, rectOpt, color) =
    let
      val sdlRect_c =
        convert_SDL_Rect rectOpt
      val result =
        SDL_FillRect_stub (surface, sdlRect_c, color)
      val _ =
        stub_DestroyRect sdlRect_c
    in
      checkSuccess result
    end

  (* SDL_UpdateWindowSurface *)
  val SDL_UpdateWindowSurface_stub = _import "SDL_UpdateWindowSurface" : SDL_Window -> int
  fun SDL_UpdateWindowSurface window =
    checkSuccess (SDL_UpdateWindowSurface_stub window)

  (* SDL_MapRGB *)
  val SDL_MapRGB = _import "SDL_MapRGB" : (SDL_PixelFormat, word8, word8, word8) -> word32

  (* SDL_Event *)
  type SDL_Event_c = unit ptr
  val stub_DestroyEvent = _import "stub_DestroyEvent" : SDL_Event_c -> ()
  val SDL_Event_GetType = _import "SDL_Event_GetType" : SDL_Event_c -> int

  datatype SDL_MouseButtonIndex =
      SDL_BUTTON_LEFT
    | SDL_BUTTON_MIDDLE
    | SDL_BUTTON_RIGHT
    | SDL_BUTTON_X1
    | SDL_BUTTON_X2

  type SDL_MouseMotionEvent =
    {
      x: int,
      y: int
    }

  val stub_SDL_MouseMotionEvent_GetX = _import "SDL_MouseMotionEvent_GetX" : SDL_Event_c -> int
  val stub_SDL_MouseMotionEvent_GetY = _import "SDL_MouseMotionEvent_GetY" : SDL_Event_c -> int

  type SDL_MouseButtonEvent =
    {
      button: SDL_MouseButtonIndex,
      x: int,
      y: int
    }
  
  val stub_SDL_MouseButtonEvent_GetX = _import "SDL_MouseButtonEvent_GetX" : SDL_Event_c -> int
  val stub_SDL_MouseButtonEvent_GetY = _import "SDL_MouseButtonEvent_GetY" : SDL_Event_c -> int
  val stub_SDL_MouseButtonEvent_GetButton = _import "SDL_MouseButtonEvent_GetButton" : SDL_Event_c -> int
 
  datatype SDL_Event =
      SDL_QUIT
    (* iOS evnets *)
    | SDL_APP_TERMINATING
    | SDL_APP_LOWMEMORY
    | SDL_APP_WILLENTERBACKGROUND
    | SDL_APP_DIDENTERBACKGROUND
    | SDL_APP_WILLENTERFOREGROUND
    | SDL_APP_DIDENTERFOREGROUND
    | SDL_LOCALECHANGED
    (* Display events *)
    | SDL_DISPLAYEVENT
    (* Window events *)
    | SDL_WINDOWEVENT
    | SDL_SYSWMEVENT
    (* Keyboard events *)
    | SDL_KEYDOWN
    | SDL_KEYUP
    | SDL_TEXTEDITING
    | SDL_TEXTINPUT
    | SDL_KEYMAPCHANGED
    (* Mouse events *)
    | SDL_MOUSEMOTION of SDL_MouseMotionEvent
    | SDL_MOUSEBUTTONDOWN of SDL_MouseButtonEvent
    | SDL_MOUSEBUTTONUP of SDL_MouseButtonEvent
    | SDL_MOUSEWHEEL
    (* Joystick events *)
    | SDL_JOYAXISMOTION
    | SDL_JOYBALLMOTION
    | SDL_JOYHATMOTION
    | SDL_JOYBUTTONDOWN
    | SDL_JOYBUTTONUP
    | SDL_JOYDEVICEADDED
    | SDL_JOYDEVICEREMOVED
    (* Game controller events *)
    | SDL_CONTROLLERAXISMOTION
    | SDL_CONTROLLERBUTTONDOWN
    | SDL_CONTROLLERBUTTONUP
    | SDL_CONTROLLERDEVICEADDED
    | SDL_CONTROLLERDEVICEREMOVED
    | SDL_CONTROLLERDEVICEREMAPPED
    | SDL_CONTROLLERTOUCHPADDOWN
    | SDL_CONTROLLERTOUCHPADMOTION
    | SDL_CONTROLLERTOUCHPADUP
    | SDL_CONTROLLERSENSORUPDATE
    (* Touch events *)
    | SDL_FINGERDOWN
    | SDL_FINGERUP
    | SDL_FINGERMOTION
    (* Gesture events *)
    | SDL_DOLLARGESTURE
    | SDL_DOLLARRECORD
    | SDL_MULTIGESTURE
    (* Clipboard events *)
    | SDL_CLIPBOARDUPDATE
    (* Drag and drop events *)
    | SDL_DROPFILE
    | SDL_DROPTEXT
    | SDL_DROPBEGIN
    | SDL_DROPCOMPLETE
    (* Audio hotplug events *)
    | SDL_AUDIODEVICEADDED
    | SDL_AUDIODEVICEREMOVED
    (* Sensor events *)
    | SDL_SENSORUPDATE
    (* Render events *)
    | SDL_RENDER_TARGETS_RESET
    | SDL_RENDER_DEVICE_RESET
    (* User event *)
    | SDL_USEREVENT

  (* SDL_PollEvent *)
  val stub_SDL_PollEvent = _import "stub_SDL_PollEvent" : () -> SDL_Event_c
  fun SDL_PollEvent () =
    let
      val event_c = stub_SDL_PollEvent ()
    in
      if Pointer.isNull event_c
      then NONE
      else
        let
          val event =
            case SDL_Event_GetType event_c of
                256 => SDL_QUIT
              (* iOS evnets *)
              | 257 => SDL_APP_TERMINATING
              | 258 => SDL_APP_LOWMEMORY
              | 259 => SDL_APP_WILLENTERBACKGROUND
              | 260 => SDL_APP_DIDENTERBACKGROUND
              | 261 => SDL_APP_WILLENTERFOREGROUND
              | 262 => SDL_APP_DIDENTERFOREGROUND
              | 263 => SDL_LOCALECHANGED
              (* Display events *)
              | 336 => SDL_DISPLAYEVENT
              (* Window events *)
              | 512 => SDL_WINDOWEVENT
              | 513 => SDL_SYSWMEVENT
              (* Keyboard events *)
              | 768 => SDL_KEYDOWN
              | 769 => SDL_KEYUP
              | 770 => SDL_TEXTEDITING
              | 771 => SDL_TEXTINPUT
              | 772 => SDL_KEYMAPCHANGED
              (* Mouse events *)
              | 1024 => SDL_MOUSEMOTION
                {
                  x = stub_SDL_MouseMotionEvent_GetX event_c,
                  y = stub_SDL_MouseMotionEvent_GetY event_c
                }
              | 1025 => SDL_MOUSEBUTTONDOWN
                {
                  button = case stub_SDL_MouseButtonEvent_GetButton event_c of
                      1 => SDL_BUTTON_LEFT
                    | 2 => SDL_BUTTON_MIDDLE
                    | 3 => SDL_BUTTON_RIGHT
                    | 4 => SDL_BUTTON_X1
                    | _ => SDL_BUTTON_X2,
                  x = stub_SDL_MouseButtonEvent_GetX event_c,
                  y = stub_SDL_MouseButtonEvent_GetY event_c
                }
              | 1026 => SDL_MOUSEBUTTONUP
                {
                  button = case stub_SDL_MouseButtonEvent_GetButton event_c of
                      1 => SDL_BUTTON_LEFT
                    | 2 => SDL_BUTTON_MIDDLE
                    | 3 => SDL_BUTTON_RIGHT
                    | 4 => SDL_BUTTON_X1
                    | _ => SDL_BUTTON_X2,
                  x = stub_SDL_MouseButtonEvent_GetX event_c,
                  y = stub_SDL_MouseButtonEvent_GetY event_c
                }
              | 1027 => SDL_MOUSEWHEEL
              (* Joystick events *)
              | 1536 => SDL_JOYAXISMOTION
              | 1537 => SDL_JOYBALLMOTION
              | 1538 => SDL_JOYHATMOTION
              | 1539 => SDL_JOYBUTTONDOWN
              | 1540 => SDL_JOYBUTTONUP
              | 1541 => SDL_JOYDEVICEADDED
              | 1542 => SDL_JOYDEVICEREMOVED
              (* Game controller events *)
              | 1616 => SDL_CONTROLLERAXISMOTION
              | 1617 => SDL_CONTROLLERBUTTONDOWN
              | 1618 => SDL_CONTROLLERBUTTONUP
              | 1619 => SDL_CONTROLLERDEVICEADDED
              | 1620 => SDL_CONTROLLERDEVICEREMOVED
              | 1621 => SDL_CONTROLLERDEVICEREMAPPED
              | 1622 => SDL_CONTROLLERTOUCHPADDOWN
              | 1623 => SDL_CONTROLLERTOUCHPADMOTION
              | 1624 => SDL_CONTROLLERTOUCHPADUP
              | 1625 => SDL_CONTROLLERSENSORUPDATE
              (* Touch events *)
              | 1792 => SDL_FINGERDOWN
              | 1793 => SDL_FINGERUP
              | 1794 => SDL_FINGERMOTION
              (* Gesture events *)
              | 2048 => SDL_DOLLARGESTURE
              | 2049 => SDL_DOLLARRECORD
              | 2050 => SDL_MULTIGESTURE
              (* Clipboard events *)
              | 2304 => SDL_CLIPBOARDUPDATE
              (* Drag and drop events *)
              | 4096 => SDL_DROPFILE
              | 4097 => SDL_DROPTEXT
              | 4098 => SDL_DROPBEGIN
              | 4099 => SDL_DROPCOMPLETE
              (* Audio hotplug events *)
              | 4352 => SDL_AUDIODEVICEADDED
              | 4353 => SDL_AUDIODEVICEREMOVED
              (* Sensor events *)
              | 4608 => SDL_SENSORUPDATE
              (* Render events *)
              | 8192 => SDL_RENDER_TARGETS_RESET
              | 8193 => SDL_RENDER_DEVICE_RESET
              (* User event *)
              | 32768 => SDL_USEREVENT
              (* otherwise *)
              | _ =>
                raise (SDL_Error "unknown SDL event")
          val _ = stub_DestroyEvent event_c
        in
          SOME event
        end
    end

  (* SDL_Renderer *)
  type SDL_Renderer = unit ptr

  (* SDL_RendererFlags *)
  datatype SDL_RendererFlags =
      SDL_RENDERER_SOFTWARE
    | SDL_RENDERER_ACCELERATED
    | SDL_RENDERER_PRESENTVSYNC
    | SDL_RENDERER_TARGETTEXTURE

  (* SDL_CreateRenderer *)
  val SDL_CreateRenderer_stub = _import "SDL_CreateRenderer" : (SDL_Window, int, word32) -> SDL_Renderer
  fun SDL_CreateRenderer (window, index, flags) =
    let
      val flags =
        foldl Word32.orb 0wx0
          (
            map
              (fn SDL_RENDERER_SOFTWARE => 0wx00000001
                | SDL_RENDERER_ACCELERATED => 0wx00000002
                | SDL_RENDERER_PRESENTVSYNC => 0wx00000004
                | SDL_RENDERER_TARGETTEXTURE => 0wx00000008
              )
              flags
          )
      val renderer = SDL_CreateRenderer_stub (window, index, flags)
    in
      if Pointer.isNull renderer
      then
        raise (SDL_Error (SDL_GetError ()))
      else
        renderer
    end

  (* SDL_GetRenderer *)
  val SDL_GetRenderer_stub = _import "SDL_GetRenderer" : SDL_Window -> SDL_Renderer
  fun SDL_GetRenderer window =
    let
      val renderer = SDL_GetRenderer_stub window
    in
      if Pointer.isNull renderer then
        raise (SDL_Error (SDL_GetError ()))
      else
        renderer
    end

  (* SDL_DestroyRenderer *)
  val SDL_DestroyRenderer = _import "SDL_DestroyRenderer" : SDL_Renderer -> ()

  (* SDL_SetRenderDrawColor *)
  val SDL_SetRenderDrawColor_stub = _import "SDL_SetRenderDrawColor" : (SDL_Renderer, word8, word8, word8, word8) -> int
  fun SDL_SetRenderDrawColor (renderer, r, g, b, a) =
    checkSuccess (SDL_SetRenderDrawColor_stub (renderer, r, g, b, a))

  (* SDL_RenderClear *)
  val SDL_RenderClear_stub = _import "SDL_RenderClear" : SDL_Renderer -> int
  fun SDL_RenderClear renderer =
    checkSuccess (SDL_RenderClear_stub renderer)

  (* SDL_RenderPresent *)
  val SDL_RenderPresent = _import "SDL_RenderPresent" : SDL_Renderer -> ()

  (* SDL_RenderDrawRect *)
  val SDL_RenderDrawRect_stub = _import "SDL_RenderDrawRect" : (SDL_Renderer, SDL_Rect_c) -> int
  fun SDL_RenderDrawRect (renderer, rectOpt) =
    let
      val sdlRect_c =
        convert_SDL_Rect rectOpt
      val result =
        SDL_RenderDrawRect_stub (renderer, sdlRect_c)
      val _ =
        stub_DestroyRect sdlRect_c
    in
      checkSuccess result
    end

  (* SDL_RenderFillRect *)
  val SDL_RenderFillRect_stub = _import "SDL_RenderFillRect" : (SDL_Renderer, SDL_Rect_c) -> int
  fun SDL_RenderFillRect (renderer, rectOpt) =
    let
      val sdlRect_c =
        convert_SDL_Rect rectOpt
      val result =
        SDL_RenderFillRect_stub (renderer, sdlRect_c)
      val _ =
        stub_DestroyRect sdlRect_c
    in
      checkSuccess result
    end

  (* SDL_RenderDrawLine *)
  val SDL_RenderDrawLine_stub = _import "SDL_RenderDrawLine" : (SDL_Renderer, int, int, int, int) -> int
  fun SDL_RenderDrawLine (renderer, x1, y1, x2, y2) =
    checkSuccess (SDL_RenderDrawLine_stub (renderer, x1, y1, x2, y2))

  (* SDL_RenderDrawPoint *)
  val SDL_RenderDrawPoint_stub = _import "SDL_RenderDrawPoint" : (SDL_Renderer, int, int) -> int
  fun SDL_RenderDrawPoint (renderer, x, y) =
    checkSuccess (SDL_RenderDrawPoint_stub (renderer, x, y))
end
