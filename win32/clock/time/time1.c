#define UNICODE
#include <stdint.h>
#include <stdio.h>
// #include <time.h> // this is a MUST to make time(time_t *) right!!!
#include <windows.h>

#define EPOCH_DIFF 116444736000000000 // times 100 nano seconds.

int main(int argc, char *argv[]) {
  printf("sizeof(long)   = %zu\n", sizeof(long));
  printf("sizeof(size_t) = %zu\n", sizeof(size_t));
  
  time_t ts1 = 0x0000000100000000;
  time_t ts2 = 0;
  time(&ts1);
  time(&ts2);
  printf("time(&ts1)     = %zu\n", ts1);
  printf("time(&ts2)     = %zu\n", ts2);

  return 0;
}
