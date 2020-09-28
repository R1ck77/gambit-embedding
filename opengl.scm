(include "common.scm")

(c-declare "#include <GL/gl.h>")

;;; Constants
(define gl-color-buffer-bit (uint-c-constant "GL_COLOR_BUFFER_BIT"))

;;; Methods
(define gl-clear-color (c-lambda (float float float float) void "glClearColor"))
(define gl-clear (c-lambda (int32) void "glClear"))


