#include <stdio.h>
#include <sys/time.h>
#include <time.h>

int main(int argc, char *argv[]) {
  struct timeval tv;
  struct tm *timeinfo;
  char buffer[32];
  gettimeofday(&tv, NULL);
  timeinfo = localtime(&tv.tv_sec);
  strftime(buffer, sizeof(buffer), "%F %T", timeinfo);
  printf("%ld.%06ld => %s\n", tv.tv_sec, tv.tv_usec, buffer);
  printf("%ld.%06lds = %ldms\n", tv.tv_sec, tv.tv_usec, 
         (tv.tv_sec * 1000 + (tv.tv_usec / 1000)));

  return 0;
}
