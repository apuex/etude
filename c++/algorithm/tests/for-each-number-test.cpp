#include <iostream>
#include <iomanip>
#include <algorithm>
#include <cstdlib>

int main(int argc, char* argv[]) {
  std::for_each( argv
               , argv + 8
               , [](auto i) {
                 std::cout << i << std::endl;
               });
  return EXIT_SUCCESS;
}

