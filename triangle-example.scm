(load "opengl")

(define vertex-shader "#version 100
uniform mat4 uMVPMatrix;
attribute vec4 vPosition;

void main() {
  gl_Position = uMVPMatrix * vPosition;
}")

(define fragment-shader "#version 100
precision mediump float;
uniform vec4 vColor;

void main() {
  gl_FragColor = vColor;
}")

(define coords-per-vertex 3)

;; counterclockwise order
(define triangle-coords (list 0.0  0.622008459 0.0
                              -0.5 -0.311004243 0.0
                              0.5 -0.311004243 0.0))
(define triangle-coords-buffer  (opengl-create-float-array triangle-coords))

;; all those constants are probably overkill
(define vertex-count (/ (length triangle-coords) coords-per-vertex))

(define vertex-stride (* coords-per-vertex 4))

;; TODO/FIXME watch out for the alpha value
(define color '(0.63671875 0.76953125 0.22265625 0.5))

(define (compile-program)
  (let ((program (opengl-program-from-sources vertex-shader fragment-shader)))
    (gl-validate-program program)
    (if (= gl-false (gl-get-program-iv program gl-validate-status))
        (begin
          (println "Program not validated")
          (println "The infolog content is:")
          (println (gl-get-program-info-log program))
          (error "illegal state")))
    program))

;; TODO/FIXME missing free
(define (draw-triangle program mvp-matrix)
  (gl-use-program program)
  (let ((position-handle (gl-get-attrib-location program "vPosition"))
        (mvp-matrix-location (gl-get-uniform-location program "uMVPMatrix"))
        (vColor-location (gl-get-uniform-location program "vColor")))
    (gl-enable-vertex-attrib-array position-handle)
    (gl-vertex-attrib-pointer position-handle coords-per-vertex gl-float (integer->char gl-false) 12 triangle-coords-buffer)
    (gl-uniform-4-fv vColor-location 1 (apply opengl-create-color color))
    (gl-uniform-matrix-4-fv mvp-matrix-location
                            1
                            (integer->char gl-false)
                            (opengl-create-float-array (list 1.0 0.0 0.0 0.0
                                                             0.0 1.0 0.0 0.0
                                                             0.0 0.0 1.0 0.0
                                                             0.0 0.0 0.0 1.0)))
    (gl-draw-arrays gl-triangles 0 3)
    (gl-disable-vertex-attrib-array position-handle)))

