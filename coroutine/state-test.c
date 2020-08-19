#include <stdlib.h>
#include <stdio.h>

#define BEGIN_STATE(state)  switch(*state) { case 0:
#define HANDLE_STATE(state, op) case __LINE__: *state = __LINE__;  if(!op()) return;
#define END_STATE(state) case __LINE__: *state = __LINE__;  return; }

static int c = 0;

int operation() {
  int v = (c++ % 2);
  if(v) printf("bingo!\n");
  else printf("bango.\n");
  return v; 
}

void state_test(int *state) {
  BEGIN_STATE(state)

    HANDLE_STATE(state, operation);
    printf("state = %d\n", *state);
    
    HANDLE_STATE(state, operation);
    printf("state = %d\n", *state);
    
    HANDLE_STATE(state, operation);
    printf("state = %d\n", *state);
    
    HANDLE_STATE(state, operation);
    printf("state = %d\n", *state);
    
    HANDLE_STATE(state, operation);
    printf("state = %d\n", *state);
    
    HANDLE_STATE(state, operation);
    printf("state = %d\n", *state);
    
    HANDLE_STATE(state, operation);
    printf("state = %d\n", *state);

  END_STATE(state)
}

int main(int argc, char* argv[]) {
  int state = 0;
 
  for(int i = 0; i < 10; ++i) state_test(&state);
  
  return EXIT_SUCCESS;
}


