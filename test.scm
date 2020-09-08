
(c-declare "
#include <string.h>

char *hello_world()
{
   return strdup(\"Hello, World!\");
}")

(define say-hello (c-lambda () char-string "hello_world"))

(display (string-append (say-hello) "\n"))

(define (print-forever)
  (display
   (string-append
    (say-hello) "\n"))
  (print-forever))

(print-forever)


