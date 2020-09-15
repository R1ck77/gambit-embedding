
(c-declare "
 #include <SDL.h>")

(c-declare "
inline static char *convertPointer(const char *string)
{
    return (char *) string;
}")

(define sdl-init (c-lambda (unsigned-int32) int "SDL_Init"))
(define sdl-quit (c-lambda () void "SDL_Quit"))
(define sdl-log (c-lambda (char-string char-string) void "SDL_Log"))
(define sdl-get-error (c-lambda () char-string "___return((char *) SDL_GetError());"))
(define sdl-everything )

(when (not (= 0 (sdl-init 0)))
    (sdl-log  "Some error happened %s!\n" (sdl-get-error))
    (exit 1))

(sdl-log "Initialization complete!%s\n" "")
(sdl-quit)


