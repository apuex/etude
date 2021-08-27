#include <stdio.h>
#include <stdint.h>
#include <sys/time.h>
#include <time.h>

int main(int argc, char *argv[]) {
  time_t mask = -1;
  struct timeval tv;
  struct tm *timeinfo;
  char buffer[32];
  gettimeofday(&tv, NULL);
  timeinfo = localtime(&tv.tv_sec);
  strftime(buffer, sizeof(buffer), "%F %T", timeinfo);
  
  // cannot work (msecs = 0) on mipsel(loongson) process.
  // uint64_t msecs = (tv.tv_sec * (uint64_t)1000 + (tv.tv_usec / 1000));
  printf("%zu.%06zu  => [%s]\n", 
         tv.tv_sec, 
         tv.tv_usec, 
         buffer);
  printf("%zu.%06zus => %zums(64bit)\n", 
         tv.tv_sec, 
         tv.tv_usec, 
         (tv.tv_sec * (uint64_t)1000 + (tv.tv_usec / 1000)));
  time_t msecs32 = mask & (tv.tv_sec * (uint64_t)1000 + (tv.tv_usec / 1000));
  printf("%zu.%06zus => %zums(32bit)\n", 
         tv.tv_sec, 
         tv.tv_usec,
         msecs32);

  return 0;
}
