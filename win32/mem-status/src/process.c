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

  if (FALSE == GetProcessImageFileName( hProcess
                                        , ExeName
                                        , ExeNameLen)
                                        ) return;
  
  // Print the process identifier.
  wprintf(L"\nProcess ID: %lu, Name: %s\n", processID, ExeName);
  if ( GetProcessMemoryInfo( hProcess, &pmc, sizeof(pmc)) )
  {
    wprintf(L"\tPageFaultCount             : %I32u\n", pmc.PageFaultCount );
    wprintf(L"\tPeakWorkingSetSize         : %I64u\n", pmc.PeakWorkingSetSize );
    wprintf(L"\tWorkingSetSize             : %I64u\n", pmc.WorkingSetSize );
    wprintf(L"\tQuotaPeakPagedPoolUsage    : %I64u\n", pmc.QuotaPeakPagedPoolUsage );
    wprintf(L"\tQuotaPagedPoolUsage        : %I64u\n", pmc.QuotaPagedPoolUsage );
    wprintf(L"\tQuotaPeakNonPagedPoolUsage : %I64u\n", pmc.QuotaPeakNonPagedPoolUsage );
    wprintf(L"\tQuotaNonPagedPoolUsage     : %I64u\n", pmc.QuotaNonPagedPoolUsage );
    wprintf(L"\tPagefileUsage              : %I64u\n", pmc.PagefileUsage ); 
    wprintf(L"\tPeakPagefileUsage          : %I64u\n", pmc.PeakPagefileUsage );
  }
  
  CloseHandle( hProcess );
}

int main(int argc, char* argv[]) {
  DWORD ProcessIds[8192] = {0};
  DWORD ProcessIdCount = 0;
  DWORD ProcessIdByteCount = 0;
  LPWSTR pMessage = L"%1!I64u! %2!s!";
  DWORD i;

  if (EnumProcesses(ProcessIds, sizeof(ProcessIds), &ProcessIdByteCount)) {
    ProcessIdCount = ProcessIdByteCount/sizeof(DWORD);
    wprintf(L"Process ID count: %lu\n", ProcessIdCount);
    for (i = 0; i != ProcessIdCount; ++i) {
      PrintMemoryInfo(ProcessIds[i]);
    }
  }
  else {
#define BUFF_SIZE 1024+1
    WCHAR buffer[BUFF_SIZE] = { 0 };

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

