#include <windows.h>
#include <stdio.h>

int main(int argc, char* argv[]) {

#define size 1024+1
  WCHAR buffer[size];

  MEMORYSTATUSEX ms;
  ms.dwLength = sizeof(MEMORYSTATUSEX);
  GlobalMemoryStatusEx(&ms);

  LPWSTR pMessage = L"%1!*s! %3!zu!%4%n"
                    L"%5!*s! %7!zu!%n"
                    L"%8!*s! %10!zu!%n"
                    L"%11!*s! %13!zu!%n"
                    L"%14!*s! %16!zu!%n"
                    L"%17!*s! %19!zu!%n"
                    L"%20!*s! %21!zu!";
  DWORD_PTR pArgs[] = {
    (DWORD_PTR)20, (DWORD_PTR)L"dwMemoryLoad:", ms.dwMemoryLoad, (DWORD_PTR)L"%",
    (DWORD_PTR)20, (DWORD_PTR)L"ullTotalPhys:", ms.ullTotalPhys,
    (DWORD_PTR)20, (DWORD_PTR)L"ullAvailPhys:", ms.ullAvailPhys,
    (DWORD_PTR)20, (DWORD_PTR)L"ullTotalPageFile:", ms.ullTotalPageFile,
    (DWORD_PTR)20, (DWORD_PTR)L"ullAvailPageFile:", ms.ullAvailPageFile,
    (DWORD_PTR)20, (DWORD_PTR)L"ullTotalVirtual:", ms.ullTotalVirtual,
    (DWORD_PTR)20, (DWORD_PTR)L"ullAvailVirtual:", ms.ullAvailVirtual
  };

  if (!FormatMessage(FORMAT_MESSAGE_FROM_STRING | FORMAT_MESSAGE_ARGUMENT_ARRAY,
                     pMessage, 
                     0,
                     0,
                     buffer, 
                     size, 
                     (va_list*)pArgs)) {
    wprintf(L"Format message failed with 0x%x\n", GetLastError());
  } else {
    //MessageBox(NULL, buffer, L"Memory Status", MB_OK);
    wprintf(L"Memory Status:\n%s\n", buffer);
  }

  return 0;
}
