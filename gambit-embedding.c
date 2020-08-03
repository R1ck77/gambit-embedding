#include <stdlib.h>
#include <stdio.h>
#include <gambit.h>
#include "myeval.h"

#define SCHEME_LIBRARY_LINKER ___LNK_myeval__

___BEGIN_C_LINKAGE
extern ___mod_or_lnk SCHEME_LIBRARY_LINKER (___global_state);
___END_C_LINKAGE

int main(int argc, char *argv[]) {

  ___setup_params_struct setup_params;
  setup_params.linker = SCHEME_LIBRARY_LINKER;

  ___setup_params_reset(&setup_params);
  ___setup(&setup_params);

  // TODO/FIXME is this memory mine?
  char *result = simple_call();
  fprintf(stderr, "Got '%s' from scheme!\n", result);
  ___cleanup();
  
  return 0;
}
