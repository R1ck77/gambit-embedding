(c-declare #<<end-of-c-declare
#include "myeval.h"
end-of-c-declare
)

(c-define (simple-call) ()  nonnull-char-string "simple_call" ""          
   "Hello, World!")
