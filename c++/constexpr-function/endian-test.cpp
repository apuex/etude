#include <iostream>
#include <cstdint>
#include <cstdlib>

constexpr int is_bigendian()
{
  const uint16_t us = 0x0001;
  const uint8_t* const pb = reinterpret_cast<const uint8_t*>(&us);
  return static_cast<int>(pb[1]);
}

int main(int argc, char* argv[])
{
  std::cout
      << "the endianness of this machine is : "
      << (is_bigendian() ? "BIG-Endian" : "LITTLE-Endian")
      << std::endl
      ;

  return EXIT_SUCCESS;
}

