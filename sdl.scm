
(c-declare "#include <SDL.h>")

(c-declare "
inline static char *convertPointer(const char *string)
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

(define simple-sdl-create-window-and-renderer (c-lambda (int int) int
" SDL_Window *window;
SDL_Renderer *renderer;
___return(SDL_CreateWindowAndRenderer(___arg1, ___arg2, SDL_WINDOW_RESIZABLE, &window, &renderer));"))


(when (not (= 0 (sdl-init sdl-init-everything)))
  (sdl-log  "Some error happened %s!\n" (sdl-get-error))
  (exit 1))

(when (not (= (simple-sdl-create-window-and-renderer 320 200) 0))
  (sdl-log "Unable to create the window and the renderer")
  (exit 2))

(sdl-log "Initialization complete!%s\n" "")


(sdl-quit)


