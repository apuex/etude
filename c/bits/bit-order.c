#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>

/*
$ gcc -o bit-order bit-order.c
$ ./bit-order
rep.bits.bit0 = 0
rep.bits.bit1 = 1
rep.bits.bit2 = 0
rep.bits.bit3 = 0
rep.bits.bit4 = 0
rep.bits.bit5 = 0
rep.bits.bit6 = 0
rep.bits.bit7 = 1
$
*/

// struct __attribute__((packed)) is a MUST!
struct __attribute__((packed)) uint8_bits {
  unsigned int bit0:1;
  unsigned int bit1:1;
  unsigned int bit2:1;
  unsigned int bit3:1;
  unsigned int bit4:1;
  unsigned int bit5:1;
  unsigned int bit6:1;
  unsigned int bit7:1;
  unsigned int bit8:1;
  unsigned int bit9:1;
  unsigned int bit10:1;
  unsigned int bit11:1;
  unsigned int bit12:1;
  unsigned int bit13:1;
  unsigned int bit14:1;
  unsigned int bit15:1;
};

union uint8_bits_rep {
  struct uint8_bits bits;
  uint16_t number;
};

void bit_rep(uint16_t number)
{
  union uint8_bits_rep rep;
  rep.number = number;

  printf("The bit Representation(bit 0 ~ bit 15) of Number 0x%04X is:\r\n", rep.number);
  for(size_t i = 0; i != (8 * sizeof(rep.number)); ++i)
  {
    printf("Bit[%ld] = %d\r\n", i, ((rep.number >> i) & 0x1));
  }

  printf("The bit Representation of Number 0x%04X using struct is:\r\n", rep.number);
  printf("rep.bits.bit0 = %d\r\n", rep.bits.bit0);
  printf("rep.bits.bit1 = %d\r\n", rep.bits.bit1);
  printf("rep.bits.bit2 = %d\r\n", rep.bits.bit2);
  printf("rep.bits.bit3 = %d\r\n", rep.bits.bit3);
  printf("rep.bits.bit4 = %d\r\n", rep.bits.bit4);
  printf("rep.bits.bit5 = %d\r\n", rep.bits.bit5);
  printf("rep.bits.bit6 = %d\r\n", rep.bits.bit6);
  printf("rep.bits.bit7 = %d\r\n", rep.bits.bit7);
  printf("rep.bits.bit8 = %d\r\n", rep.bits.bit8);
  printf("rep.bits.bit9 = %d\r\n", rep.bits.bit9);
  printf("rep.bits.bit10 = %d\r\n", rep.bits.bit10);
  printf("rep.bits.bit11 = %d\r\n", rep.bits.bit11);
  printf("rep.bits.bit12 = %d\r\n", rep.bits.bit12);
  printf("rep.bits.bit13 = %d\r\n", rep.bits.bit13);
  printf("rep.bits.bit14 = %d\r\n", rep.bits.bit14);
  printf("rep.bits.bit15 = %d\r\n", rep.bits.bit15);
}

int main(int argc, char* argv[])
{
  bit_rep(0x8213);
  return EXIT_SUCCESS;
}

