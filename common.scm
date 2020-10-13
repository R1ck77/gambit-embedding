(c-declare "#include <stdlib.h>")

(define-macro (c-constant name type)
  `((c-lambda () ,type ,(string-append "___return(" name ");"))))

(define-macro (int-c-constant name)
  `(c-constant ,name int))

(define-macro (uint-c-constant name)
  `(c-constant ,name unsigned-int32))

(define-macro (comment . forms)
  #f)

(c-declare "long int scm_free(void *memory) {
    free(memory);
    return 0;
}")

