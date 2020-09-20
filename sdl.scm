
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

;;; SDL procedures
(define sdl-init (c-lambda (unsigned-int32) int "SDL_Init"))
(define sdl-quit (c-lambda () void "SDL_Quit"))
(define sdl-log (c-lambda (char-string char-string) void "SDL_Log"))
(define sdl-get-error (c-lambda () char-string "___return((char *) SDL_GetError());"))

(c-define-type window-ptr (pointer (type "SDL_Renderer") (SDL_Renderer) "scm_free"))
(define create-window-ptr (c-lambda () window-ptr "___return(malloc(sizeof(SDL_Window*)));"))
(c-define-type renderer-ptr (pointer (type "SDL_Window") (SDL_Window) "scm_free"))
(define create-renderer-ptr (c-lambda () renderer-ptr "___return(malloc(sizeof(SDL_Renderer*)));"))

(c-declare "long int scm_free(void *memory) {
    free(memory);
    return 0;
}")

;; TODO/FIXME static typing
(define simple-sdl-create-window-and-renderer (c-lambda (int int window-ptr renderer-ptr) int
"
SDL_Window *window = ___arg3;
//SDL_Renderer *renderer = ___arg4;
//___return(SDL_CreateWindowAndRenderer(___arg1, ___arg2, SDL_WINDOW_RESIZABLE, &window, &renderer));
___return(12);
"))

(when (not (= 0 (sdl-init sdl-init-everything)))
  (sdl-log  "Some error happened %s!\n" (sdl-get-error))
  (exit 1))

(let ((window-ptr (create-window-ptr))
      (renderer-ptr (create-renderer-ptr)))
  (when (not (= (simple-sdl-create-window-and-renderer 320 200 window-ptr renderer-ptr) 0))
    (sdl-log "Unable to create the window and the renderer" "")
    (exit 2)))

(sdl-log "Initialization complete!%s\n" "")


(sdl-quit)

