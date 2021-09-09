#include <limits.h>
#include <stdio.h>
#include <stdlib.h>


int main(int argc, char *argv[]) {
  char path[PATH_MAX];
  
  realpath(argv[0], path);
  printf("The realpath of [%s] is [%s]\n", argv[0], path);

  return EXIT_SUCCESS;
}

