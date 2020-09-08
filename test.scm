
;; This one leaks
(c-declare "
#include <string.h>
#include <stdlib.h>

char *hello_world()
{
   return strdup(\"Hello, World!\");
}")

(define say-hello (c-lambda () char-string
                            " char *output = hello_world();
#define ___AT_END free(output);
___return (output); "))

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
    (say-hello) "\n"))
  (print-forever))

(print-forever)


