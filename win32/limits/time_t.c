#include <stdlib.h>
#include <stdio.h>
#include <time.h>


int main(int argc, char* argv[]) {
  time_t t;
  time(&t);

  printf("time_t t = %llu\n", t);
  printf("t & 0xffffffff = %llu\n", t & 0xffffffff);

  return EXIT_SUCCESS;
}
