(include "common.scm")

(c-declare "#include <GLES2/gl2.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>")

(include "opengl-types.scm")
(include "opengl-constants.scm")


;;; Methods
(define gl-clear-color (c-lambda (GLfloat GLfloat GLfloat GLfloat) void "glClearColor"))
(define gl-clear (c-lambda (GLbitfield) void "glClear"))
(define gl-get-error (c-lambda () GLenum "glGetError"))
(define gl-create-program (c-lambda () GLuint "glCreateProgram")) ; cleanup action
(define gl-delete-program (c-lambda (GLuint) void "glDeleteProgram"))
(define gl-use-program (c-lambda (GLuint) void "glUseProgram"))
(define gl-is-program? (c-lambda (GLuint) GLboolean "glIsProgram"))
(define gl-link-program (c-lambda (GLuint) void "glLinkProgram"))

(define __gl-get-program-iv (c-lambda (GLuint GLenum GLint-pointer) void "glGetProgramiv"))
(define (gl-get-program-iv program parameter)
  (let ((result (opengl-create-int-array (list 0))))
    (__gl-get-program-iv program parameter result)
    (get-GLint-pointer-element result 0)))
(define __gl-get-program-info-log (c-lambda (GLuint) GLchar-pointer "
   int length[0];
   glGetProgramiv(___arg1, GL_INFO_LOG_LENGTH, length);
   if(length[0] > 1) {
     char *result = calloc(length[0], sizeof(GLchar));
     glGetProgramInfoLog(___arg1, length[0], NULL, result);
     ___return(result);
   } else {
     ___return(strdup(\"\"));
   }"))
(define (gl-get-program-info-log program)
  (opengl-char-array-as-string
   (__gl-get-program-info-log program)))

(define __gl-get-shader-iv (c-lambda (GLuint GLenum GLint-pointer) void "glGetShaderiv"))
(define (gl-get-shader-iv shader parameter)
  (let ((result (opengl-create-int-array (list 0))))
    (__gl-get-shader-iv shader parameter result)
    (get-GLint-pointer-element result 0)))
(define __gl-get-shader-info-log (c-lambda (GLuint) GLchar-pointer "
   int length[0];
   glGetShaderiv(___arg1, GL_INFO_LOG_LENGTH, length);
   if(length[0] > 1) {
     char *result = calloc(length[0], sizeof(GLchar));
     glGetShaderInfoLog(___arg1, length[0], NULL, result);
     ___return(result);
   } else {
     ___return(strdup(\"\"));
   }"))
(define (gl-get-shader-info-log shader)
  (opengl-char-array-as-string
   (__gl-get-shader-info-log shader)))



(define gl-blend-func (c-lambda (GLenum GLenum) void "glBlendFunc"))
(define gl-enable (c-lambda (GLenum) void "glEnable"))
(define gl-validate-program (c-lambda (GLuint) void "glValidateProgram"))
(define gl-get-attrib-location (c-lambda (GLuint char-string) GLint "glGetAttribLocation"))
(define gl-enable-vertex-attrib-array (c-lambda (GLuint) void "glEnableVertexAttribArray"))
(define gl-disable-vertex-attrib-array (c-lambda (GLuint) void "glDisableVertexAttribArray"))
(define gl-attach-shader (c-lambda (GLuint GLuint) void "glAttachShader"))
(define gl-detach-shader (c-lambda (GLuint GLuint) void "glDetachShader"))
(define gl-delete-shader (c-lambda (GLuint) void "glDeleteShader"))
(define gl-create-shader (c-lambda (GLenum) GLuint "glCreateShader")) ; cleanup action
(define gl-shader-source (c-lambda (GLuint char-string) void "const GLchar *shaders[1];
shaders[0] = ___arg2;
glShaderSource(___arg1, 1, shaders, NULL); "))
(define gl-compile-shader (c-lambda (GLuint) void "glCompileShader"))
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
(define gl-uniform-1-fv (c-lambda (GLint GLsizei GLfloat-pointer) void "glUniform1fv"))
(define gl-uniform-2-fv (c-lambda (GLint GLsizei GLfloat-pointer) void "glUniform2fv"))
(define gl-uniform-3-fv (c-lambda (GLint GLsizei GLfloat-pointer) void "glUniform3fv"))
(define gl-uniform-4-fv (c-lambda (GLint GLsizei GLfloat-pointer) void "glUniform4fv"))
(define gl-uniform-1-iv (c-lambda (GLint GLsizei (pointer GLint)) void "glUniform1iv"))
(define gl-uniform-2-iv (c-lambda (GLint GLsizei (pointer GLint)) void "glUniform2iv"))
(define gl-uniform-3-iv (c-lambda (GLint GLsizei (pointer GLint)) void "glUniform3iv"))
(define gl-uniform-4-iv (c-lambda (GLint GLsizei (pointer GLint)) void "glUniform4iv"))
(define gl-uniform-matrix-2-fv (c-lambda (GLint GLsizei GLboolean GLfloat-pointer) void "glUniformMatrix2fv"))
(define gl-uniform-matrix-3-fv (c-lambda (GLint GLsizei GLboolean GLfloat-pointer) void "glUniformMatrix3fv"))
(define gl-uniform-matrix-4-fv (c-lambda (GLint GLsizei GLboolean GLfloat-pointer) void "glUniformMatrix4fv"))
(define gl-vertex-attrib-pointer (c-lambda (GLuint GLint GLenum GLboolean GLsizei vertex-data) void "glVertexAttribPointer"))
(define gl-enable-vertex-attrib-array (c-lambda (GLuint) void "glEnableVertexAttribArray"))
(define gl-disable-vertex-attrib-array (c-lambda (GLuint) void "glDisableVertexAttribArray"))
(define gl-get-attrib-location (c-lambda (GLuint char-string) GLint "glGetAttribLocation"))

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
 (define gl-uniform-matrix-2x3-fv (c-lambda (GLint GLsizei GLboolean GLfloat-pointer) void "glUniformMatrix2x3fv"))
 (define gl-uniform-matrix-3x2-fv (c-lambda (GLint GLsizei GLboolean GLfloat-pointer) void "glUniformMatrix3x2fv"))
 (define gl-uniform-matrix-2x4-fv (c-lambda (GLint GLsizei GLboolean GLfloat-pointer) void "glUniformMatrix2x4fv"))
 (define gl-uniform-matrix-4x2-fv (c-lambda (GLint GLsizei GLboolean GLfloat-pointer) void "glUniformMatrix4x2fv"))
 (define gl-uniform-matrix-3x4-fv (c-lambda (GLint GLsizei GLboolean GLfloat-pointer) void "glUniformMatrix3x4fv"))
 (define gl-uniform-matrix-4x3-fv (c-lambda (GLint GLsizei GLboolean GLfloat-pointer) void "glUniformMatrix4x3fv")))

(define (opengl-create-shader type code)
  (let ((shader (gl-create-shader type)))
    (gl-shader-source shader code)
    (gl-compile-shader shader)
    (if (not (= gl-true (gl-get-shader-iv shader gl-compile-status)))
        (begin
          (println "For shader:")
          (println code)
          (println (gl-get-shader-info-log shader))
          (error "Shader not compiled correctly!")))
    shader))

(define (opengl-create-vertex-shader code)
  (opengl-create-shader gl-vertex-shader code))

(define (opengl-create-fragment-shader code)
  (opengl-create-shader gl-fragment-shader code))

(define (opengl-create-program vertex-shader fragment-shader)
  (let ((program (gl-create-program)))
    (gl-attach-shader program vertex-shader)
    (gl-attach-shader program fragment-shader)
    (gl-link-program program)
    (gl-detach-shader program vertex-shader)
    (gl-detach-shader program fragment-shader)
    program))

(define (opengl-program-from-sources vertex-shader-code fragment-shader-code)
  (opengl-create-program (opengl-create-vertex-shader vertex-shader-code)
                         (opengl-create-fragment-shader fragment-shader-code)))

(define (opengl-create-color r g b a)
  (opengl-create-float-array (list r g b a)))

(define (opengl-matrix-identity)
  (opengl-create-float-array (list 1.0 0.0 0.0 0.0
                                   0.0 1.0 0.0 0.0
                                   0.0 0.0 1.0 0.0
                                   0.0 0.0 0.0 1.0)))
