(include "common.scm")

(c-declare "#include <GLES2/gl2.h>")

(c-define-type GLenum unsigned-int)
(c-define-type GLuint unsigned-int)
(c-define-type GLint int)
(c-define-type GLfloat float)
(c-define-type GLbitfield unsigned-int)
(c-define-type GLsizei int)
(c-define-type GLchar char)

;;; Constants
(define gl-color-buffer-bit (uint-c-constant "GL_COLOR_BUFFER_BIT"))
(define gl-vertex-shader (uint-c-constant "GL_VERTEX_SHADER"))
(define gl-fragment-shader (uint-c-constant "GL_FRAGMENT_SHADER"))

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


