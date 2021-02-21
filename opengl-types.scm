(c-define-type GLenum unsigned-int) ; TODO/FIXME conflicting documentation: check if unsigned!
(c-define-type GLuint unsigned-int)
(c-define-type GLint int)
(c-define-type GLfloat float)
(c-define-type GLbitfield unsigned-int)
(c-define-type GLsizei int)
(c-define-type GLchar char)
(c-define-type GLboolean unsigned-char)

;;; GLint*
(c-define-type GLint-pointer (pointer "GLint" GLint* "scm_free"))

(define get-GLint-pointer-element (c-lambda (GLint-pointer int) GLint
                                          "___return(___arg1[___arg2]);"))

(c-define (get-int-element-as-c list index) (scheme-object int) GLint
          "get_int_element_as_c"
          ""
          (list-ref list index))

(define __opengl-create-int-array (c-lambda (scheme-object int)
                                            GLint-pointer
                                            "
GLint *result = calloc(___arg2, sizeof(GLint));
for(int i = 0; i < ___arg2; ++i) {
    result[i] = (GLint) get_int_element_as_c(___arg1, i);
}
___return(result);"))

(define (opengl-create-int-array int-list)
  (__opengl-create-int-array int-list (length int-list)))

;;; GLFloat*
(c-define-type GLfloat-pointer (pointer "GLfloat" GLfloat* "scm_free"))

(c-define (get-float-element-as-c list index) (scheme-object int) GLfloat
          "get_float_element_as_c"
          ""
          (list-ref list index))

(define get-GLfloat-pointer-element (c-lambda (GLfloat-pointer int) GLfloat
                                            "___return(___arg1[___arg2]);"))

(define opengl-create-empty-float-array (c-lambda (int)
                                                    GLfloat-pointer
                                                    "___return(calloc(___arg1, sizeof(GLfloat)));"))

(define __opengl-set-float-array! (c-lambda (GLfloat-pointer scheme-object int)
                                           void
                                           "
for(int i = 0; i < ___arg3; ++i) {
    ___arg1[i] = (GLfloat) get_float_element_as_c(___arg2, i);
}"))

(define (opengl-set-float-array! float-pointer float-list)
  (__opengl-set-float-array! float-pointer float-list (length float-list)))

(define __opengl-create-float-array (c-lambda (scheme-object int)
                                            GLfloat-pointer
                                            "
GLfloat *result = calloc(___arg2, sizeof(GLfloat));
for(int i = 0; i < ___arg2; ++i) {
    result[i] = (GLfloat) get_float_element_as_c(___arg1, i);
}
___return(result);"))

(define (opengl-create-float-array float-list)
  (__opengl-create-float-array float-list (length float-list)))

;;; GLsizei*
(c-define-type GLsizei-pointer (pointer "GLsizei" GLsizei* "scm_free"))

(c-define (get-sizei-element-as-c list index) (scheme-object int) GLsizei
          "get_sizei_element_as_c"
          ""
          (list-ref list index))

;;; TODO/FIXE extra
(define opengl-create-sizei-array-size (c-lambda (int) GLsizei-pointer
                                                "___return((GLsizei*) malloc(___arg1));"))


(define __opengl-create-sizei-array (c-lambda (scheme-object int)
                                            GLsizei-pointer
                                            "
GLsizei *result = calloc(___arg2, sizeof(GLsizei));
for(int i = 0; i < ___arg2; ++i) {
    result[i] = (GLsizei) get_sizei_element_as_c(___arg1, i);
}
___return(result);"))

(define (opengl-create-sizei-array sizei-list)
  (__opengl-create-sizei-array sizei-list (length sizei-list)))

;;; GLchar*
(c-define-type GLchar-pointer (pointer "GLchar" GLchar* "scm_free"))

(c-define (get-char-element-as-c list index) (scheme-object int) GLchar
          "get_char_element_as_c"
          ""
          (list-ref list index))

(define __opengl-create-char-array (c-lambda (scheme-object int)
                                            GLchar-pointer
                                            "
GLchar *result = calloc(___arg2, sizeof(GLchar));
for(int i = 0; i < ___arg2; ++i) {
    result[i] = (GLchar) get_char_element_as_c(___arg1, i);
}
___return(result);"))

(define (opengl-create-char-array char-list)
  (__opengl-create-char-array char-list (length char-list)))

;;; TODO/FIXE extra
(define opengl-create-char-array-size (c-lambda (int) GLchar-pointer
                                                "___return((GLchar*) malloc(___arg1));"))

(define opengl-char-array-as-string (c-lambda (GLchar-pointer) char-string
                                              "fprintf(stderr, \"CONTENT: '%s'\\n\", ___arg1);
___return(___arg1);"))

(c-define-type vertex-data (pointer "void" (void* GLfloat* GLint*) "scm_free"))
