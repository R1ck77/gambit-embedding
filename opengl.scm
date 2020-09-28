(include "common.scm")

(c-declare "#include <GLES2/gl2.h>")

(c-define-type GLenum unsigned-int)
(c-define-type GLuint unsigned-int)
(c-define-type GLfloat float)
(c-define-type GLbitfield unsigned-int)


;;; Constants
(define gl-color-buffer-bit (uint-c-constant "GL_COLOR_BUFFER_BIT"))
(define gl-vertex-shader (uint-c-constant "GL_VERTEX_SHADER"))
(define gl-fragment-shader (uint-c-constant "GL_FRAGMENT_SHADER"))

;;; Methods
(define gl-clear-color (c-lambda (GLfloat GLfloat GLfloat GLfloat) void "glClearColor"))
(define gl-clear (c-lambda (GLbitfield) void "glClear"))
(define gl-create-shader (c-lambda (GLenum) GLuint "glCreateShader"))


