#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

int main(int argc, char* argv[]) {
  if(1 == argc)
  {
    printf("%s <number>\n", argv[0]);
    return EXIT_FAILURE;
  }

  int n = atoi(argv[1]);
  printf("module%02d\n", n);

  return EXIT_SUCCESS;
}
