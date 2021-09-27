#include <windows.h>

int APIENTRY WinMain( HINSTANCE hInst
                    , HINSTANCE hInstPrev
                    , PSTR cmdline
                    , int cmdshow
                    ) {
  return MessageBox( NULL
                   , TEXT("Hello, World!\nA Warmest welcome from Wangxy.")
                   , TEXT("Geetings from Wangxy")
                   , 0
                   );                    
}
