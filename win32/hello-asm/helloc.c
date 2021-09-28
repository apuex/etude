#include <windows.h>

void helloc(HANDLE hConsoleOutput) {
  TCHAR msg[] = TEXT("\nHello from C.\n");
  DWORD written;
  WriteConsole(
    hConsoleOutput,
    msg,
    ARRAYSIZE(msg),
    &written,
    NULL
  );
}
