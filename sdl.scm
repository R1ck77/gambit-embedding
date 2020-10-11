(include "common.scm")
(load "opengl")

(c-declare "#include <SDL.h>")

(c-declare "inline static char *convertPointer(const char *string)
{
    return (char *) string;
}")


;;; SDL Constants
(define sdl-init-everything (int-c-constant "SDL_INIT_EVERYTHING"))
(define sdl-init-video (int-c-constant "SDL_INIT_VIDEO"))
(define sdl-init-audio (int-c-constant "SDL_INIT_AUDIO"))
(define sdl-init-events (int-c-constant "SDL_INIT_EVENTS"))
(define sdl-windowpos-undefined (int-c-constant "SDL_WINDOWPOS_UNDEFINED"))
(define sdl-window-shown (int-c-constant "SDL_WINDOW_SHOWN"))
(define sdl-renderer-accelerated (int-c-constant "SDL_RENDERER_ACCELERATED"))
(define sdl-quit-const (int-c-constant "SDL_QUIT"))


;;; SDL procedures
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
(c-declare "long int scm_free_gl_context(SDL_GLContext context) {
    SDL_GL_DeleteContext(context);
    return 0;
}")
(c-define-type sdl-gl-context (pointer (type "SDL_GLContext") (void) "scm_free_gl_context"))
(define sdl-gl-create-context (c-lambda (window-ptr) sdl-gl-context "SDL_GL_CreateContext"))


(define sdl-create-window-and-renderer (c-lambda (int int window-ptr renderer-ptr)
                                                 int
                                                 " SDL_Window* window =  ___arg3;
SDL_Renderer *renderer =  ___arg4;
___return(SDL_CreateWindowAndRenderer(___arg1, ___arg2, SDL_WINDOW_RESIZABLE, &window, &renderer));"))
(define sdl-delay (c-lambda (unsigned-int32) void "SDL_Delay"))
(define sdl-gl-swap-window (c-lambda (window-ptr) void "SDL_GL_SwapWindow"))

;; SDL_Event
(c-define-type sdl-event (pointer (type "SDL_Event") (void)))
(define create-sdl-event (c-lambda () sdl-event "___return(malloc(sizeof(SDL_Event)));"))
(define get-event-type (c-lambda (sdl-event) int "___return(___arg1->type);"))
(define sdl-poll-event! (c-lambda (sdl-event) void "SDL_PollEvent(___arg1);"))



;; TODO/FIXME unused
(c-declare "long int scm_free(void *memory) {
    free(memory);
    return 0;
}")

(define-macro (comment . forms)
  #f)

(define (initialize-sdl)
  (when (not (= 0 (sdl-init sdl-init-everything)))
    (sdl-log  "Some error happened %s!\n" (sdl-get-error))
    (exit 1)))

(define (intercept-error message exit-code)
  (sdl-log message (sdl-get-error))
  (exit exit-code))

;;; TODO/FIXME for some reason the renderer is doesn't work. I think it's a memory
(define (initialize-window-old width height)
  (initialize-sdl)
  (let ((window-ptr (create-window-ptr))
        (renderer-ptr (create-renderer-ptr)))
    (when (not (= (sdl-create-window-and-renderer width height window-ptr renderer-ptr) 0))
      (intercept-error "Unable to create the window and the renderer: %s\n" 2))
    (sdl-log "Initialization complete!%s\n" "")
    renderer-ptr))

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

(define (wait-for-quit event callback)
  (sdl-poll-event! event)
  (when (not (= (get-event-type event) sdl-quit-const))
    (apply callback (list event))
    (wait-for-quit event callback)))


(define triangle-vertex-shader "uniform mat4 uMVPMatrix;
attribute vec4 vPosition;

void main() {
  gl_Position = uMVPMatrix * vPosition;
}")

(define triangle-fragment-shader "precision mediump float;
uniform vec4 vColor;

void main() {
  gl_FragColor = vColor;
}")

(define (create-shaders)
  (display (opengl-program-from-sources triangle-vertex-shader triangle-fragment-shader))
  (display "\n"))

(define window (initialize-opengl-window 640 480))
(create-shaders)
(wait-for-quit (create-sdl-event)
               (lambda (event)                 
                 (gl-clear-color 0.0 0.0 1.0 1.0)
                 (gl-clear gl-color-buffer-bit)
                 (sdl-gl-swap-window window)
                 #f))
(sdl-quit)
