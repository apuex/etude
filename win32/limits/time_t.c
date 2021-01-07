#include <stdlib.h>
#include <stdio.h>
#include <time.h>


int main(int argc, char* argv[]) {
  time_t t;
  time(&t);

  printf("time_t t = %lu\n", t);
  printf("t & 0xffffffff = %lu\n", t & 0xffffffff);

  return EXIT_SUCCESS;
}
