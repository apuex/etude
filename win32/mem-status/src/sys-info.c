#include <windows.h>
#include <stdio.h>

int main(int argc, char* argv[]) {

#define size 1024+1
  WCHAR buffer[size];

  SYSTEM_INFO  si;
  GetSystemInfo(&si);
  switch (si.wProcessorArchitecture) {
  case PROCESSOR_ARCHITECTURE_AMD64:
    wprintf(L"     wProcessorArchitecture: PROCESSOR_ARCHITECTURE_AMD64\n");
    break;
  case PROCESSOR_ARCHITECTURE_IA64:
    wprintf(L"     wProcessorArchitecture: PROCESSOR_ARCHITECTURE_IA64\n");
    break;
  case PROCESSOR_ARCHITECTURE_INTEL:
    wprintf(L"     wProcessorArchitecture: PROCESSOR_ARCHITECTURE_INTEL\n");
    break;
  case PROCESSOR_ARCHITECTURE_UNKNOWN:
    wprintf(L"     wProcessorArchitecture: PROCESSOR_ARCHITECTURE_UNKNOWN\n");
    break;
  }
  wprintf(L"                  wReserved: 0x%04X\n", si.wReserved);
  wprintf(L"                 dwPageSize: 0x%04X\n", si.dwPageSize);
  wprintf(L"lpMinimumApplicationAddress: 0x%016zX\n", (size_t)si.lpMinimumApplicationAddress);
  wprintf(L"lpMaximumApplicationAddress: 0x%016zX\n", (size_t)si.lpMaximumApplicationAddress);
  wprintf(L"      dwActiveProcessorMask: 0x%08zX\n", si.dwActiveProcessorMask);
  wprintf(L"       dwNumberOfProcessors: %u\n", si.dwNumberOfProcessors);
  switch (si.dwProcessorType) {
  case PROCESSOR_INTEL_386:
    wprintf(L"            dwProcessorType: PROCESSOR_INTEL_386(%d)\n", si.dwProcessorType);
    break;
  case PROCESSOR_INTEL_486:
    wprintf(L"            dwProcessorType: PROCESSOR_INTEL_486(%d)\n", si.dwProcessorType);
    break;
  case PROCESSOR_INTEL_PENTIUM:
    wprintf(L"            dwProcessorType: PROCESSOR_INTEL_PENTIUM(%d)\n", si.dwProcessorType);
    break;
  case PROCESSOR_INTEL_IA64:
    wprintf(L"            dwProcessorType: PROCESSOR_INTEL_IA64(%d)\n", si.dwProcessorType);
    break;
  case PROCESSOR_AMD_X8664:
    wprintf(L"            dwProcessorType: PROCESSOR_AMD_X8664(%d)\n", si.dwProcessorType);
    break;
  }
  wprintf(L"    dwAllocationGranularity: 0x%08X\n", si.dwAllocationGranularity);
  wprintf(L"            wProcessorLevel: 0x%04X\n", si.wProcessorLevel);
  wprintf(L"         wProcessorRevision: 0x%04X\n", si.wProcessorRevision);

  return 0;
}
