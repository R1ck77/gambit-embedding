(load "sdl")
(load "triangle-example")

(define (update-function window event program)
  (gl-clear-color 0.0 0.0 1.0 1.0)
  (gl-clear gl-color-buffer-bit)
  (draw-triangle program (opengl-matrix-identity))
  (sdl-gl-swap-window window))


(define (demo-function width height)
  (let ((window (initialize-opengl-window width height))
        (program (compile-program)))
    (wait-for-quit (create-sdl-event)
                   (lambda (event)
                     (update-function window event program)))
    (gl-delete-program program)
    (sdl-quit)))

(c-define (demo-function-c width height) (int int) void
          "demo_function"
          ""
          (demo-function width height))
