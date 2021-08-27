#define UNICODE
#include <stdint.h>
#include <stdio.h>
#include <time.h>
#include <windows.h>

#define EPOCH_DIFF 116444736000000000 // times 100 nano seconds.

int main(int argc, char *argv[]) {
  printf("sizeof(long)   = %zu\n", sizeof(long));
  printf("sizeof(size_t) = %zu\n", sizeof(size_t));
  
  time_t ts1;
  time_t ts2;
  struct tm *timeinfo1;
  struct tm *timeinfo2;
  char buffer1[32], buffer2[32];
  time(&ts1);
  time(&ts2);
  timeinfo1 = localtime(&ts1);
  strftime(buffer1, sizeof(buffer1), "%F %T", timeinfo1);
  timeinfo2 = localtime(&ts2);
  strftime(buffer2, sizeof(buffer2), "%F %T", timeinfo2);

  printf("time(&ts1)     = %zu => [%s]\n", ts1, buffer1);
  printf("time(&ts2)     = %zu => [%s]\n", ts2, buffer2);

  return 0;
}
