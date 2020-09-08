
(c-declare "
#include <stdlib.h>
#include <string.h>")

(c-declare "char *hello_world()
{
   return strdup(\"Hello, World!\");
}")

(define sane-hello (c-lambda () char-string
                             "char *output = hello_world();
#define ___AT_END free(output);
___return (output);"))

(define nice-but-leaking-hello (c-lambda () char-string "hello_world"))

(define (eat-memory)
  (display (string-append (nice-but-leaking-hello) "\n"))
  (eat-memory))

(eat-memory)


