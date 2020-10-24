(load "sdl")
(load "triangle-example")

(define (update-function window program event)
  (gl-clear-color 0.0 0.0 1.0 1.0)
  (gl-clear gl-color-buffer-bit)
  (draw-triangle program (opengl-matrix-identity))
  (sdl-gl-swap-window window))


(define print-step)

(define (wrap-function-with-time-printing f)
  (let ((checkpoint (time->seconds (current-time)))
        (count 0))
    (lambda args
      (apply f args)
      (set! count (+ 1 count))
      (let* ((now (time->seconds (current-time)))
             (diff (- now checkpoint)))
        (when (>= (- now checkpoint) 1)
          (println (/  count diff) " FPS (" count ", " diff ")")
          (set! checkpoint now)
          (set! count 0))))))


(define (demo-function width height)
  (let* ((window (initialize-opengl-window width height))
        (program (compile-program))
        (f (wrap-function-with-time-printing (lambda (event)
                                               (update-function window program event)))))
    (wait-for-quit (create-sdl-event) f)
    (gl-delete-program program)
    (sdl-quit)))

(c-define (demo-function-c width height) (int int) void
          "demo_function"
          ""
          (demo-function width height))
