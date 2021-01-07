#include <stdio.h>
#include <string.h>
#include <time.h>
#include <errno.h>
/*
#include <linux/rtc.h>
#include <sys/ioctl.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
*/


int main() {
  time_t clock;
  time_t one_year_after;
  struct tm mile_stone = {0};
  double seconds;
/*
  int fd;
  struct rtc_time rt;
*/
  time(&clock);
  memcpy(&mile_stone, localtime(&clock), sizeof(struct tm));

  mile_stone.tm_year = 1 + mile_stone.tm_year;

  one_year_after = mktime(&mile_stone);
  seconds = difftime(clock, one_year_after);

  printf("%.f seconds 1 year from now in the current timezone.\n", seconds);

  printf("before stime(): %lu - %lu.\n", clock, one_year_after);
  if(0 == stime(&one_year_after)) {
    printf("set system time success(%d).\n", errno);
  } else {
    printf("set system time failure(%d).\n", errno);
  }
  time(&clock);
  printf("after stime(): %lu - %lu.\n", clock, one_year_after);
/*
  rt.tm_sec = mile_stone.tm_sec;
  rt.tm_min = mile_stone.tm_min;
  rt.tm_hour = mile_stone.tm_hour;
  rt.tm_mday = mile_stone.tm_mday;
  rt.tm_mon = mile_stone.tm_mon;
  rt.tm_year = mile_stone.tm_year;

  fd = open("/dev/rtc", O_RDONLY);
  ioctl(fd, RTC_SET_TIME, &rt);
  close(fd);
*/
  return 0;
}
