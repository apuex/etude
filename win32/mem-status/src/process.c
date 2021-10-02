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
    wprintf(L"\tPageFaultCount             : %u\n",  pmc.PageFaultCount );
    wprintf(L"\tPeakWorkingSetSize         : %llu\n", pmc.PeakWorkingSetSize );
    wprintf(L"\tWorkingSetSize             : %llu\n", pmc.WorkingSetSize );
    wprintf(L"\tQuotaPeakPagedPoolUsage    : %llu\n", pmc.QuotaPeakPagedPoolUsage );
    wprintf(L"\tQuotaPagedPoolUsage        : %llu\n", pmc.QuotaPagedPoolUsage );
    wprintf(L"\tQuotaPeakNonPagedPoolUsage : %llu\n", pmc.QuotaPeakNonPagedPoolUsage );
    wprintf(L"\tQuotaNonPagedPoolUsage     : %llu\n", pmc.QuotaNonPagedPoolUsage );
    wprintf(L"\tPagefileUsage              : %llu\n", pmc.PagefileUsage ); 
    wprintf(L"\tPeakPagefileUsage          : %llu\n", pmc.PeakPagefileUsage );
  }
  
  CloseHandle( hProcess );
}

int main(int argc, char* argv[]) {
  DWORD ProcessIds[8192] = {0};
  DWORD ProcessIdCount = 0;
  DWORD ProcessIdByteCount = 0;
  LPWSTR pMessage = L"%1!llu! %2!s!";
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

