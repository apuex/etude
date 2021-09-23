#include <windows.h>
#include <stdio.h>
#include <psapi.h>

void PrintMemoryInfo( DWORD processID )
{
  HANDLE hProcess;
  PROCESS_MEMORY_COUNTERS pmc;
  WCHAR ExeName[MAX_PATH] = L"";
  DWORD ExeNameLen = ARRAYSIZE(ExeName);

  // Print information about the memory usage of the process.
  hProcess = OpenProcess(  PROCESS_QUERY_INFORMATION |
    PROCESS_VM_READ,
    FALSE, processID );
  if (NULL == hProcess) return;

  if (FALSE == QueryFullProcessImageName( hProcess
                                        , 0             // PROCESS_NAME_NATIVE
                                        , ExeName
                                        , &ExeNameLen)
                                        ) return;
  
  // Print the process identifier.
  wprintf(L"\nProcess ID: %u, Name: %s\n", processID, ExeName);
  if ( GetProcessMemoryInfo( hProcess, &pmc, sizeof(pmc)) )
  {
    wprintf(L"\tPageFaultCount             : %u\n",  pmc.PageFaultCount );
    wprintf(L"\tPeakWorkingSetSize         : %zu\n", pmc.PeakWorkingSetSize );
    wprintf(L"\tWorkingSetSize             : %zu\n", pmc.WorkingSetSize );
    wprintf(L"\tQuotaPeakPagedPoolUsage    : %zu\n", pmc.QuotaPeakPagedPoolUsage );
    wprintf(L"\tQuotaPagedPoolUsage        : %zu\n", pmc.QuotaPagedPoolUsage );
    wprintf(L"\tQuotaPeakNonPagedPoolUsage : %zu\n", pmc.QuotaPeakNonPagedPoolUsage );
    wprintf(L"\tQuotaNonPagedPoolUsage     : %zu\n", pmc.QuotaNonPagedPoolUsage );
    wprintf(L"\tPagefileUsage              : %zu\n", pmc.PagefileUsage ); 
    wprintf(L"\tPeakPagefileUsage          : %zu\n", pmc.PeakPagefileUsage );
  }
  
  CloseHandle( hProcess );
}

int main(int argc, char* argv[]) {
  DWORD ProcessIds[8192] = {0};
  DWORD ProcessIdCount = 0;
  DWORD ProcessIdByteCount = 0;
  LPWSTR pMessage = L"%1!zu! %2!s!";

#define BUFF_SIZE 1024+1
  WCHAR buffer[BUFF_SIZE] = { 0 };

  if (EnumProcesses(ProcessIds, sizeof(ProcessIds), &ProcessIdByteCount)) {
    ProcessIdCount = ProcessIdByteCount/sizeof(DWORD);
    wprintf(L"Process ID count: %lu\n", ProcessIdCount);
    for (DWORD i = 0; i != ProcessIdCount; ++i) {
      PrintMemoryInfo(ProcessIds[i]);
    }
  }
  else {
    FormatMessage(FORMAT_MESSAGE_FROM_SYSTEM
      , NULL
      , GetLastError()
      , 0
      , buffer
      , BUFF_SIZE
      , NULL
    );
    wprintf(L"%s\n", buffer);
  }
  return 0;
}

