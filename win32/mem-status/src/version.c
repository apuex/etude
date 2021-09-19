#include <windows.h>
#include <stdio.h>

int main(int argc, char* argv[]) {
  OSVERSIONINFO  osver;
  osver.dwOSVersionInfoSize = sizeof(OSVERSIONINFO);
  GetVersionEx(&osver);

  switch (osver.dwPlatformId) {
  case VER_PLATFORM_WIN32s:
    wprintf(L"VER_PLATFORM_WIN32s: ");
    break;
  case VER_PLATFORM_WIN32_WINDOWS:
    wprintf(L"VER_PLATFORM_WIN32_WINDOWS: ");
    break;
  case VER_PLATFORM_WIN32_NT:
    wprintf(L"VER_PLATFORM_WIN32_NT: ");
    break;
  }
  
  wprintf(L"%d.%d.%d %s\n"
    , osver.dwMajorVersion
    , osver.dwMinorVersion
    , osver.dwBuildNumber
    , osver.szCSDVersion);

  OSVERSIONINFOEXW osvi = { sizeof(osvi), 0, 0, 0, 0, {0}, 0, 0 };
  DWORDLONG        const dwlConditionMask = VerSetConditionMask(
    VerSetConditionMask(
      VerSetConditionMask(
        0, VER_MAJORVERSION, VER_GREATER_EQUAL),
      VER_MINORVERSION, VER_GREATER_EQUAL),
    VER_SERVICEPACKMAJOR, VER_GREATER_EQUAL);

  osvi.dwMajorVersion = 6;
  osvi.dwMinorVersion = 2;
  osvi.wServicePackMajor = 0;

  BOOL ok = VerifyVersionInfoW(&osvi, VER_MAJORVERSION | VER_MINORVERSION | VER_SERVICEPACKMAJOR, dwlConditionMask) != FALSE;
  wprintf(L"ok = %d\n", ok);

  return 0;
}
