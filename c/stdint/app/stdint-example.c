#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

int main(int argc, char* argv[]) {
  printf("sizeof(int8_t)   = %lu\n", sizeof(int8_t));
  printf("sizeof(int16_t)  = %lu\n", sizeof(int16_t));
  printf("sizeof(int32_t)  = %lu\n", sizeof(int32_t));
  printf("sizeof(int64_t)  = %lu\n", sizeof(int64_t));

  printf("sizeof(uint8_t)  = %lu\n", sizeof(uint8_t));
  printf("sizeof(uint16_t) = %lu\n", sizeof(uint16_t));
  printf("sizeof(uint32_t) = %lu\n", sizeof(uint32_t));
  printf("sizeof(uint64_t) = %lu\n", sizeof(uint64_t));

  return 0;
}
