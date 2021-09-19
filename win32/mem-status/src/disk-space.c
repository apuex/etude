#include <windows.h>
#include <stdio.h>

int main(int argc, char* argv[]) {
  ULARGE_INTEGER available;
  ULARGE_INTEGER total;
  ULARGE_INTEGER free;

  GetDiskFreeSpaceEx(NULL, &available, &total, &free);

  wprintf(L"            total: %zu\n", total.QuadPart);
  wprintf(L"             free: %zu\n", free.QuadPart);
  wprintf(L"available to user: %zu\n", available.QuadPart);

  return 0;
}
