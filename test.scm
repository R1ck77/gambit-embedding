
(c-declare "
#include <stdlib.h>
#include <string.h>")

(c-declare "char *hello_world()
{
   return strdup(\"Hello, World!\");
}")

(c-declare "char *identity(char *arg) {
    return arg;
}")

(c-declare "___SCMOBJ scm_free(void *arg) {
    free(arg);
    return 0;
}" )

(define sane-hello (c-lambda () (pointer char (char*) "scm_free") "hello_world"))

(define to-string (c-lambda ((pointer char)) char-string "identity"))

(define (sane-hello-loop)
  (display (string-append (to-string (sane-hello)) "\n"))
  (sane-hello-loop))

(sane-hello-loop)


