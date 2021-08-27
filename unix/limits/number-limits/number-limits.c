#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <time.h>


int main(int argc, char *argv[]) {
  printf("sizeof(char)      = %zu\n", sizeof(char));
  printf("sizeof(short)     = %zu\n", sizeof(short));
  printf("sizeof(int)       = %zu\n", sizeof(int));
  printf("sizeof(long)      = %zu\n", sizeof(long));
  printf("sizeof(long long) = %zu\n", sizeof(long long));
  printf("sizeof(uint64_t)  = %zu\n", sizeof(uint64_t));
  printf("sizeof(float)     = %zu\n", sizeof(float));
  printf("sizeof(double)    = %zu\n", sizeof(double));
  printf("sizeof(size_t)    = %zu\n", sizeof(size_t));
  printf("sizeof(time_t)    = %zu\n", sizeof(time_t));
  return 0;
}
