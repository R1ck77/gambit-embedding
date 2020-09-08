
;; This one leaks
(c-declare "
#include <string.h>

char *hello_world()
{
   return strdup(\"Hello, World!\");
}")
(define say-hello (c-lambda () char-string "hello_world"))

;; This one does not leak
(c-declare "
char *echo(char *string)
{
    return string;
} ")
(define echo (c-lambda (char-string) char-string "echo"))

(define (print-forever)
  (display
   (string-append
    (echo "Hello, World!") "\n"))
  (print-forever))

(print-forever)


