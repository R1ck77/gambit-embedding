#include <stdlib.h>
#define ___VERSION 409003
#include <gambit.h>

#define SCHEME_LIBRARY_LINKER ___LNK_demo__

___BEGIN_C_LINKAGE
extern ___mod_or_lnk SCHEME_LIBRARY_LINKER (___global_state);
___END_C_LINKAGE

extern void demo_function(int, int);

int main(void) {
  ___setup_params_struct setup_params;
  ___setup_params_reset (&setup_params);

  setup_params.version = ___VERSION;
  setup_params.linker  = SCHEME_LIBRARY_LINKER;

  ___setup (&setup_params);

  demo_function(800, 600);

  ___cleanup ();

  return 0;
}
