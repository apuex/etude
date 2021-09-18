#include <windows.h>

int WINAPI WinMain(
    HINSTANCE hInstExe,
    HINSTANCE HInstPre,
    PWSTR pszCmdLine,
    int nCmdShow) {

  MEMORYSTATUS ms;
  GlobalMemoryStatus(&ms);

  return 0;
}
