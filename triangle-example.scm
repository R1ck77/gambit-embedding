(load "opengl")
;;;    /**
;;;     * Encapsulates the OpenGL ES instructions for drawing this shape.
;;;     *
;;;     * @param mvpMatrix - The Model View Project matrix in which to draw
;;;     * this shape.
;;;     */
;;;    public void draw(float[] mvpMatrix) {
;;;        // Add program to OpenGL environment
;;;        GLES20.glUseProgram(mProgram);
;;;        // get handle to vertex shader's vPosition member
;;;        mPositionHandle = GLES20.glGetAttribLocation(mProgram, "vPosition");
;;;        // Enable a handle to the triangle vertices
;;;        GLES20.glEnableVertexAttribArray(mPositionHandle);
;;;        // Prepare the triangle coordinate data
;;;        GLES20.glVertexAttribPointer(
;;;                mPositionHandle, COORDS_PER_VERTEX,
;;;                GLES20.GL_FLOAT, false,
;;;                vertexStride, vertexBuffer);
;;;        // get handle to fragment shader's vColor member
;;;        mColorHandle = GLES20.glGetUniformLocation(mProgram, "vColor");
;;;        // Set color for drawing the triangle
;;;        GLES20.glUniform4fv(mColorHandle, 1, color, 0);
;;;        // get handle to shape's transformation matrix
;;;        mMVPMatrixHandle = GLES20.glGetUniformLocation(mProgram, "uMVPMatrix");
;;;        MyGLRenderer.checkGlError("glGetUniformLocation");
;;;        // Apply the projection and view transformation
;;;        GLES20.glUniformMatrix4fv(mMVPMatrixHandle, 1, false, mvpMatrix, 0);
;;;        MyGLRenderer.checkGlError("glUniformMatrix4fv");
;;;        // Draw the triangle
;;;        GLES20.glDrawArrays(GLES20.GL_TRIANGLES, 0, vertexCount);
;;;        // Disable vertex array
;;;        GLES20.glDisableVertexAttribArray(mPositionHandle);
;;;    }

(define vertex-shader "uniform mat4 uMVPMatrix;
attribute vec4 vPosition;

void main() {
  gl_Position = uMVPMatrix * vPosition;
}")

(define fragment-shader "precision mediump float;
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

;; TODO/FIXME missing free
(define (draw-triangle program mvp-matrix)
  (gl-use-program program)
  (let ((position-handle (gl-get-attrib-location program "vPosition"))
        (mvp-matrix-location (gl-get-uniform-location program "uMVPMatrix"))
        (vColor-location (gl-get-uniform-location program "vColor")))
    (gl-enable-vertex-attrib-array position-handle)
    (gl-vertex-attrib-pointer position-handle coords-per-vertex gl-float false 12 triangle-coords-buffer)
    (gl-uniform-4-fv vColor-location 1 (apply opengl-create-color color))
    (gl-uniform-matrix-4-fv mvp-matrix-location 1 false mvp-matrix)
    (gl-draw-arrays gl-triangles 0 3)
    (gl-disable-vertex-attrib-array position-handle)))
