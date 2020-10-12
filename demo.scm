;;; (load "sdl")
;;; (load "opengl")
;;; 
;;; (define triangle-vertex-shader "uniform mat4 uMVPMatrix;
;;; attribute vec4 vPosition;
;;; 
;;; void main() {
;;;   gl_Position = uMVPMatrix * vPosition;
;;; }")
;;; 
;;; (define triangle-fragment-shader "precision mediump float;
;;; uniform vec4 vColor;
;;; 
;;; void main() {
;;;   gl_FragColor = vColor;
;;; }")
;;; 
;;; (define (update-function window event)
;;;   (gl-clear-color 0.0 0.0 1.0 1.0)
;;;   (gl-clear gl-color-buffer-bit)
;;;   (sdl-gl-swap-window window))
;;; 
;;; 
;;; (define (demo-function width height)
;;;   (let ((window (initialize-opengl-window width height))
;;;         (program (opengl-program-from-sources triangle-vertex-shader triangle-fragment-shader)))
;;;     (wait-for-quit (create-sdl-event)
;;;                    (lambda (event)
;;;                      (update-function window event)))
;;;     (gl-delete-program program)
;;;     (sdl-quit)))
;;; 
;;; (demo-function 800 600)

(define (hello-world)
  (display "Hello, World!\n"))
