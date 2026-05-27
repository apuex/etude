#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>
#include <string.h>

// [ 8B 56 1A 08 72 ] => (2026-05-13 16:32:28, 0x000B)
// struct __attribute__((packed)) is a MUST!
struct __attribute__((packed)) AlarmLog {
  unsigned int AlarmCode:7;
  unsigned int AlarmDay:5;
  unsigned int AlarmMonth:4;
  unsigned int AlarmYear:7;
  unsigned int AlarmHour:5;
  unsigned int AlarmMin:6;
  unsigned int AlarmSec:6;
};

union AlarmLogRepr {
  struct AlarmLog Log;
  uint8_t Bytes[5];
};

int main(int argc, char* argv[])
{
  union AlarmLogRepr repr;

  repr.Bytes[0] = 0x8B;
  repr.Bytes[1] = 0x56;
  repr.Bytes[2] = 0x1A;
  repr.Bytes[3] = 0x08;
  repr.Bytes[4] = 0x72;

  printf("sizeof(repr) = 0x%08lX\r\n", sizeof(repr));

  for(size_t i = 0; i != sizeof(repr.Bytes); ++i)
  {
    printf("repr.Bytes[%ld] = 0x%02X\r\n", i, repr.Bytes[i]);
  }

  printf( "%04d-%02d-%02d %02d:%02d:%02d => 0x%04X\r\n"
        , repr.Log.AlarmYear + 2000
        , repr.Log.AlarmMonth
        , repr.Log.AlarmDay
        , repr.Log.AlarmHour
        , repr.Log.AlarmMin
        , repr.Log.AlarmSec
        , repr.Log.AlarmCode
        );

  return EXIT_SUCCESS;
}

