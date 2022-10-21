#include <windows.h>
#include <iostream>
#include <string>

int APIENTRY WinMain( HINSTANCE hInst
                    , HINSTANCE hInstPrev
                    , PSTR cmdline
                    , int cmdshow
                    ) {
  std::string yes("Yes!");
  std::cout << yes << std::endl;
  return MessageBox( NULL
                   , TEXT("Hello, World!\nA Warmest welcome from Wangxy.")
                   , TEXT("Geetings from Wangxy")
                   , 0
                   );                    
}
