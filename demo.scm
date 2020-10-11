(load "sdl")
(load "opengl")

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
