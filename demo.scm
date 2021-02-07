(load "sdl")
(load "triangle-example")

(gc-report-set! #t)

(define max-fps 60.0)

(define buffer (opengl-create-empty-float-array 16))

(define (update-function window program event)
  (let* ((time (time->seconds (current-time)))
         (c (cos time))
         (s (sin time)))
    (gl-clear-color 0.0 0.0 1.0 1.0)
    (gl-clear gl-color-buffer-bit)
    (opengl-set-float-array! buffer (list s   c     0.0 0.0
                                          c   (- s) 0.0 0.0
                                          0.0 0.0   1.0 0.0
                                          0.0 0.0   0.0 1.0))
    (draw-triangle program buffer)))


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
  (sdl-gl-set-attribute sdl-gl-doublebuffer 1)
  (sdl-gl-set-swap-interval 1)
  (let* ((last-event (time->seconds (current-time)))
         (window (initialize-opengl-window width height))
        (program (compile-program))
        (f (wrap-function-with-time-printing (lambda (event)
                                               (update-function window program event)
                                               (sdl-gl-swap-window window)
                                               (let* ((now (time->seconds (current-time)))
                                                      (diff (- (/ 1 max-fps) (- now last-event))))
                                                 (when (> diff 0)
                                                   (sdl-delay (inexact->exact (truncate (* diff 1000)))))
                                                 (set! last-event (time->seconds (current-time))))
                                               ;;; This breaks everything!
                                               ;;(println "Stopping the world…")
                                               ;;(##gc)
                                               ;;(println "…resuming the world")
                                               ))))
    (loop-until-close (create-sdl-event) f)
    (gl-delete-program program)
    (sdl-quit)))

(c-define (demo-function-c width height) (int int) void
          "demo_function"
          ""
          (demo-function width height))
