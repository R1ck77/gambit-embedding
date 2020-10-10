(include "common.scm")

(c-declare "#include <GLES2/gl2.h>")

(c-define-type GLenum unsigned-int)
(c-define-type GLuint unsigned-int)
(c-define-type GLint int)
(c-define-type GLfloat float)
(c-define-type GLbitfield unsigned-int)
(c-define-type GLsizei int)
(c-define-type GLchar char)
(c-define-type GLboolean unsigned-char)

;;; Constants
(define gl-color-buffer-bit (uint-c-constant "GL_COLOR_BUFFER_BIT"))
(define gl-vertex-shader (uint-c-constant "GL_VERTEX_SHADER"))
(define gl-fragment-shader (uint-c-constant "GL_FRAGMENT_SHADER"))

;;; Primitives
(define gl-points (uint-c-constant "GL_POINTS"))
(define gl-line-strip (uint-c-constant "GL_LINE_STRIP"))
(define gl-line-loop (uint-c-constant "GL_LINE_LOOP"))
(define gl-lines (uint-c-constant "GL_LINES"))
(define gl-triangle-strip (uint-c-constant "GL_TRIANGLE_STRIP"))
(define gl-triangle-fan (uint-c-constant "GL_TRIANGLE_FAN"))
(define gl-triangles (uint-c-constant "GL_TRIANGLES"))

;; Error codes
(define gl-invalid-value (uint-c-constant "GL_INVALID_VALUE"))
(define gl-invalid-operation (uint-c-constant "GL_INVALID_OPERATION"))
(define gl-no-error (uint-c-constant "GL_NO_ERROR"))

;;; Methods
(define gl-clear-color (c-lambda (GLfloat GLfloat GLfloat GLfloat) void "glClearColor"))
(define gl-clear (c-lambda (GLbitfield) void "glClear"))
(define gl-get-error (c-lambda () GLenum "glGetError"))
(define gl-create-program (c-lambda () GLuint "glCreateProgram"))
(define gl-use-program (c-lambda (GLuint) void "glUseProgram"))
(define gl-link-program (c-lambda (GLuint) void "glLinkProgram"))
(define gl-get-attrib-location (c-lambda (GLuint char-string) GLint "glGetAttribLocation"))
(define gl-enable-vertex-attrib-array (c-lambda (GLuint) void "glEnableVertexAttribArray"))
(define gl-disable-vertex-attrib-array (c-lambda (GLuint) void "glDisableVertexAttribArray"))
(define gl-attach-shader (c-lambda (GLuint GLuint) void "glAttachShader"))
(define gl-create-shader (c-lambda (GLenum) GLuint "glCreateShader"))
(define gl-shader-source (c-lambda (GLuint char-string) void "const GLchar *shaders[1];
shaders[0] = ___arg2;
glShaderSource(___arg1, 1, shaders, NULL); "))
(define gl-compile-shader (c-lambda (GLuint) void "glCompileShader"))
(define gl-vertex-attrib-pointer (c-lambda (GLuint GLint GLenum GLboolean GLsizei (pointer void)) void "glVertexAttribPointer"))
(define gl-get-uniform-location (c-lambda (GLuint char-string) GLint "glGetUniformLocation"))
(define gl-draw-arrays (c-lambda (GLenum GLint GLsizei) void "glDrawArrays"))

(define gl-uniform-1-f (c-lambda (GLint GLfloat) void "glUniform1f"))
(define gl-uniform-2-f (c-lambda (GLint GLfloat GLfloat) void "glUniform2f"))
(define gl-uniform-3-f (c-lambda (GLint GLfloat GLfloat GLfloat) void "glUniform3f"))
(define gl-uniform-4-f (c-lambda (GLint GLfloat GLfloat GLfloat GLfloat) void "glUniform4f"))
(define gl-uniform-1-i (c-lambda (GLint GLint) void "glUniform1i"))
(define gl-uniform-2-i (c-lambda (GLint GLint GLint) void "glUniform2i"))
(define gl-uniform-3-i (c-lambda (GLint GLint GLint GLint) void "glUniform3i"))
(define gl-uniform-4-i (c-lambda (GLint GLint GLint GLint GLint) void "glUniform4i"))
(define gl-uniform-1-fv (c-lambda (GLint GLsizei (pointer GLfloat)) void "glUniform1fv"))
(define gl-uniform-2-fv (c-lambda (GLint GLsizei (pointer GLfloat)) void "glUniform2fv"))
(define gl-uniform-3-fv (c-lambda (GLint GLsizei (pointer GLfloat)) void "glUniform3fv"))
(define gl-uniform-4-fv (c-lambda (GLint GLsizei (pointer GLfloat)) void "glUniform4fv"))
(define gl-uniform-1-iv (c-lambda (GLint GLsizei (pointer GLint)) void "glUniform1iv"))
(define gl-uniform-2-iv (c-lambda (GLint GLsizei (pointer GLint)) void "glUniform2iv"))
(define gl-uniform-3-iv (c-lambda (GLint GLsizei (pointer GLint)) void "glUniform3iv"))
(define gl-uniform-4-iv (c-lambda (GLint GLsizei (pointer GLint)) void "glUniform4iv"))
(define gl-uniform-matrix-2-fv (c-lambda (GLint GLsizei GLboolean (pointer GLfloat)) void "glUniformMatrix2fv"))
(define gl-uniform-matrix-3-fv (c-lambda (GLint GLsizei GLboolean (pointer GLfloat)) void "glUniformMatrix3fv"))
(define gl-uniform-matrix-4-fv (c-lambda (GLint GLsizei GLboolean (pointer GLfloat)) void "glUniformMatrix4fv"))

;; found in the OpenGL ES3 documentation but not in the current header file
(comment
 (define gl-uniform-1-ui (c-lambda (GLint GLuint) void "glUniform1ui"))
 (define gl-uniform-2-ui (c-lambda (GLint GLuint GLuint) void "glUniform2ui"))
 (define gl-uniform-3-ui (c-lambda (GLint GLuint GLuint GLuint) void "glUniform3ui"))
 (define gl-uniform-4-ui (c-lambda (GLint GLint GLuint GLuint GLuint) void "glUniform4ui"))
 (define gl-uniform-1-uiv (c-lambda (GLint GLsizei (pointer GLuint)) void "glUniform1uiv"))
 (define gl-uniform-2-uiv (c-lambda (GLint GLsizei (pointer GLuint)) void "glUniform2uiv"))
 (define gl-uniform-3-uiv (c-lambda (GLint GLsizei (pointer GLuint)) void "glUniform3uiv"))
 (define gl-uniform-4-uiv (c-lambda (GLint GLsizei (pointer GLuint)) void "glUniform4uiv"))
 (define gl-uniform-matrix-2x3-fv (c-lambda (GLint GLsizei GLboolean (pointer GLfloat)) void "glUniformMatrix2x3fv"))
 (define gl-uniform-matrix-3x2-fv (c-lambda (GLint GLsizei GLboolean (pointer GLfloat)) void "glUniformMatrix3x2fv"))
 (define gl-uniform-matrix-2x4-fv (c-lambda (GLint GLsizei GLboolean (pointer GLfloat)) void "glUniformMatrix2x4fv"))
 (define gl-uniform-matrix-4x2-fv (c-lambda (GLint GLsizei GLboolean (pointer GLfloat)) void "glUniformMatrix4x2fv"))
 (define gl-uniform-matrix-3x4-fv (c-lambda (GLint GLsizei GLboolean (pointer GLfloat)) void "glUniformMatrix3x4fv"))
 (define gl-uniform-matrix-4x3-fv (c-lambda (GLint GLsizei GLboolean (pointer GLfloat))void "glUniformMatrix4x3fv")))

