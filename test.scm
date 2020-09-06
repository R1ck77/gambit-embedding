
(c-declare "char *hello_world()
{
   return \"Hello, World!\";
}")

(define say-hello (c-lambda () char-string "hello_world"))

(display (string-append (say-hello) "\n"))


