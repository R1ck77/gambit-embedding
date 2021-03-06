(include "common.scm")

(c-declare "static int warn_on_leaked_objects = 0;")

(c-declare "#include <SDL.h>")

(c-declare "inline static char *convertPointer(const char *string)
{
    return (char *) string;
}")

;;; Constants
(define sdl-init-everything (int-c-constant "SDL_INIT_EVERYTHING"))
(define sdl-init-video (int-c-constant "SDL_INIT_VIDEO"))
(define sdl-init-audio (int-c-constant "SDL_INIT_AUDIO"))
(define sdl-init-events (int-c-constant "SDL_INIT_EVENTS"))
(define sdl-windowpos-undefined (int-c-constant "SDL_WINDOWPOS_UNDEFINED"))
(define sdl-window-shown (int-c-constant "SDL_WINDOW_SHOWN"))
(define sdl-renderer-accelerated (int-c-constant "SDL_RENDERER_ACCELERATED"))
(define sdl-quit-const (int-c-constant "SDL_QUIT"))
;;; Attributes
(define sdl-gl-doublebuffer (int-c-constant "SDL_GL_DOUBLEBUFFER"))
(define sdl-gl-depth-size (int-c-constant "SDL_GL_DEPTH_SIZE"))


;;; Functions
(define sdl-init (c-lambda (unsigned-int32) int "SDL_Init"))
(define sdl-quit (c-lambda () void "SDL_Quit"))
(define sdl-log (c-lambda (char-string char-string) void "SDL_Log"))
(define sdl-get-error (c-lambda () char-string "___return((char *) SDL_GetError());"))

;; SDL_Window
(c-define-type window-ptr (pointer (type "SDL_Window") (void)))
(define create-window-ptr (c-lambda () window-ptr "___return(malloc(sizeof(SDL_Window*)));"))
(define sdl-create-window (c-lambda (char-string int int)
                                    window-ptr
                                    "___return(SDL_CreateWindow(___arg1, SDL_WINDOWPOS_UNDEFINED, SDL_WINDOWPOS_UNDEFINED, ___arg2, ___arg3, SDL_WINDOW_SHOWN | SDL_WINDOW_OPENGL));"))

;; SDL_Renderer
(c-define-type renderer-ptr (pointer (type "SDL_Renderer") (void)))
(define create-renderer-ptr (c-lambda () renderer-ptr "___return(malloc(sizeof(SDL_Renderer*)));"))
(define sdl-create-renderer (c-lambda (window-ptr int unsigned-int32)
                                      renderer-ptr
                                      "SDL_CreateRenderer"))
(define sdl-render-clear (c-lambda (renderer-ptr)
                                     void
                                     "SDL_RenderClear"))
(define sdl-render-present (c-lambda (renderer-ptr)
                                     void
                                     "SDL_RenderPresent"))

;; SDL_GL_Context
(c-declare "long int scm_notify_gl_context_leaked(SDL_GLContext context) {
    if(warn_on_leaked_objects != 0) {
        fprintf(stderr, \"*** leaking SDL Context %p…\\n\", context);
    }
    return 0;
}")
(c-define-type sdl-gl-context (pointer (type "SDL_GLContext") (void) "scm_notify_gl_context_leaked"))
(define sdl-gl-create-context (c-lambda (window-ptr) sdl-gl-context "SDL_GL_CreateContext"))
(define sdl-gl-delete-context (c-lambda (sdl-gl-context) void "SDL_GL_DeleteContext"))

;;; TODO/FIXME missing SDL_GLAttr!
(define sdl-gl-set-attribute (c-lambda (int int) int "SDL_GL_SetAttribute"))


(define sdl-create-window-and-renderer (c-lambda (int int window-ptr renderer-ptr)
                                                 int
                                                 " SDL_Window* window =  ___arg3;
SDL_Renderer *renderer =  ___arg4;
___return(SDL_CreateWindowAndRenderer(___arg1, ___arg2, SDL_WINDOW_RESIZABLE, &window, &renderer));"))
(define sdl-delay (c-lambda (unsigned-int32) void "SDL_Delay"))
(define sdl-gl-swap-window (c-lambda (window-ptr) void "SDL_GL_SwapWindow"))
(define sdl-gl-set-swap-interval (c-lambda (int) int "SDL_GL_SetSwapInterval"))

;; SDL_Event
(c-define-type sdl-event (pointer (type "SDL_Event") (void)))
(define create-sdl-event (c-lambda () sdl-event "___return(malloc(sizeof(SDL_Event)));"))
(define get-event-type (c-lambda (sdl-event) int "___return(___arg1->type);"))
(define sdl-poll-event! (c-lambda (sdl-event) int "SDL_PollEvent"))

(define (initialize-sdl)
  (when (not (= 0 (sdl-init sdl-init-everything)))
    (sdl-log  "Some error happened %s!\n" (sdl-get-error))
    (exit 1)))

(define (intercept-error message exit-code)
  (sdl-log message (sdl-get-error))
  (exit exit-code))

(define (initialize-window width height)
  (initialize-sdl)
  (let  ((window-ptr (sdl-create-window "Test Window" width height)))
    (when (not window-ptr)
      (intercept-error "Unable to create the window: %s\n" 2))
    (let ((renderer-ptr (sdl-create-renderer window-ptr -1 sdl-renderer-accelerated)))
      (when (not renderer-ptr)
        (intercept-error "Unable to create the renderer %s\n" 3))
      renderer-ptr)))

(define (initialize-opengl-window width height)
  (initialize-sdl)
  (let ((window-ptr (sdl-create-window "Test Window" width height)))
    (when (not window-ptr)
      (intercept-error "Unable to create the window: %s\n" 2))
    (let ((gl-context (sdl-gl-create-context window-ptr)))
      (when (not gl-context)
        (intercept-error "Unable to create the OpenGL context: %s\n" 3))
      window-ptr)))

(define (for-each-event! event f acc)
  (when (not (= (sdl-poll-event! event) 0))
    (for-each-event! event f (f event acc)))
  acc)

(define (should-quit? event)
  (for-each-event! event
                   (lambda (event acc)
                     (or (= (get-event-type event)
                            sdl-quit-const)))
                   #f))

(define (loop-until-close event callback)
  (when (not (should-quit? event))    
    (apply callback (list event))
    (loop-until-close event callback)))
