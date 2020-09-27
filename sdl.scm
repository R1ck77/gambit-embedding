
(c-declare "#include <SDL.h>")

(c-declare "inline static char *convertPointer(const char *string)
{
    return (char *) string;
}")

(define-macro (c-constant name type)
  `((c-lambda () ,type ,(string-append "___return(" name ");"))))

(define-macro (int-c-constant name)
  `(c-constant ,name int))

;;; Constants
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
                                    "___return(SDL_CreateWindow(___arg1, SDL_WINDOWPOS_UNDEFINED, SDL_WINDOWPOS_UNDEFINED, ___arg2, ___arg3, SDL_WINDOW_SHOWN));"))

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

(define sdl-create-window-and-renderer (c-lambda (int int window-ptr renderer-ptr)
                                                 int
                                                 " SDL_Window* window =  ___arg3;
SDL_Renderer *renderer =  ___arg4;
___return(SDL_CreateWindowAndRenderer(___arg1, ___arg2, SDL_WINDOW_RESIZABLE, &window, &renderer));"))
(define sdl-delay (c-lambda (unsigned-int32) void "SDL_Delay"))


;; SDL_Event
(c-define-type event-ptr (pointer (type "SDL_Event") (void)))
(define create-event-ptr (c-lambda () event-ptr "___return(malloc(sizeof(SDL_Event)));"))
(define get-event-type (c-lambda (event-ptr) int "___return(___arg1->type);"))
(define sdl-poll-event! (c-lambda (event-ptr) void "SDL_PollEvent(___arg1);"))

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

(define (wait-for-quit event callback)
  (sdl-poll-event! event)
  (when (not (= (get-event-type event) sdl-quit-const))
      (apply callback (list event))
      (wait-for-quit event callback)))


(define render (initialize-window 640 480))
(wait-for-quit (create-event-ptr)
               (lambda (event)
                 (sdl-render-present render)
                 (sdl-render-clear render)))
(sdl-quit)
