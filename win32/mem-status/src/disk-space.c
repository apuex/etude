#include <windows.h>
#include <stdio.h>

int main(int argc, char* argv[]) {
  ULARGE_INTEGER available;
  ULARGE_INTEGER total;
  ULARGE_INTEGER free;
  WCHAR path[MAX_PATH];

  for (int i = 0; i != argc; ++i) {
    printf("argv[%d] = %s\n", i, argv[i]);
  }
  if (argc > 1) {
    MultiByteToWideChar( GetACP()
                       , MB_PRECOMPOSED
                       , argv[1]
                       , strlen(argv[1]) + 1 // or, -1 if null terminated.
                       , path
                       , ARRAYSIZE(path)
                       );

    wprintf(L"             path: %s\n", path);
    wprintf(L"             path: %s\n", path);
    GetDiskFreeSpaceEx(path, &available, &total, &free);
  }
  else {
    GetDiskFreeSpaceEx(NULL, &available, &total, &free);
  }

  wprintf(L"        code page: %u\n", GetACP());
  wprintf(L"            total: %zu\n", total.QuadPart);
  wprintf(L"             free: %zu\n", free.QuadPart);
  wprintf(L"available to user: %zu\n", available.QuadPart);

  return 0;
}
