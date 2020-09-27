(include "common.scm")

(c-declare "#include <GL/gl.h>")

(define gl-color-buffer-bit (uint-c-constant "GL_COLOR_BUFFER_BIT"))

;; Enough OpenGL calls to show "something"
(define gl-clear-color (c-lambda (float float float float) void "glClearColor"))
(define gl-clear (c-lambda (int32) void "glClear"))
;; glClear(GL_COLOR_BUFFER_BIT)


