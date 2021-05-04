structure SDL2 =
struct
  (* SDLの例外 *)
  exception SDL_Error of string

  (* SDL_GetError *)
  val SDL_GetError_stub = _import "SDL_GetError" : () -> char ptr
  fun SDL_GetError () =
    Pointer.importString (SDL_GetError_stub ())

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
      if SDL_Init_stub flags = 0
      then
        ()
      else
        raise (SDL_Error (SDL_GetError ()))
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

  (* SDL_FillRect *)
  val SDL_FillRect_stub = _import "SDL_FillRect" : (SDL_Surface, SDL_Rect_c, word32) -> int
  fun SDL_FillRect (surface, rectOpt, color) =
    let
      val sdlRect_c =
        case rectOpt of
          NONE => Pointer.NULL ()
        | SOME {x, y, w, h} => stub_CreateRect (x, y, w, h)
      val result =
        SDL_FillRect_stub (surface, sdlRect_c, color)
      val _ =
        stub_DestroyRect sdlRect_c
    in
      if result = 0
      then ()
      else raise (SDL_Error (SDL_GetError ()))
    end

  (* SDL_UpdateWindowSurface *)
  val SDL_UpdateWindowSurface_stub = _import "SDL_UpdateWindowSurface" : SDL_Window -> int
  fun SDL_UpdateWindowSurface window =
    if SDL_UpdateWindowSurface_stub window = 0
    then ()
    else raise (SDL_Error (SDL_GetError ()))

  (* SDL_MapRGB *)
  val SDL_MapRGB = _import "SDL_MapRGB" : (SDL_PixelFormat, word8, word8, word8) -> word32

end
