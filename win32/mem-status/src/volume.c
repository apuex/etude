#include <windows.h>
#include <stdio.h>

int main(int argc, char* argv[]) {
  HANDLE volHandle = INVALID_HANDLE_VALUE;
  BOOL found = TRUE;
  WCHAR VolumeName[MAX_PATH] = L"";
  WCHAR  DeviceName[MAX_PATH] = L"";
  WCHAR  PathName[MAX_PATH + 1] = L"";
  WCHAR  DriverPathName[MAX_PATH + 1] = L"";
  PWCHAR NameIdx   = NULL;

  DWORD  CharCount = ARRAYSIZE(PathName);
  size_t index = 0;

  ULARGE_INTEGER available;
  ULARGE_INTEGER total;
  ULARGE_INTEGER free;

  volHandle = FindFirstVolume(VolumeName, sizeof(VolumeName) / sizeof(WCHAR));
  if (volHandle != INVALID_HANDLE_VALUE) {
    for (
      ;
      TRUE == found;
      found = FindNextVolume(volHandle, VolumeName, sizeof(VolumeName) / sizeof(WCHAR))
      ) {
      wprintf(L"Volume Name: %s\n", VolumeName);
      GetVolumePathNamesForVolumeName(VolumeName, PathName, CharCount, &CharCount);

      index = wcslen(VolumeName) - 1;
      VolumeName[index] = L'\0';
      QueryDosDevice(&VolumeName[4], DeviceName, ARRAYSIZE(DeviceName));
      wprintf(L"Device Name: %s\n", DeviceName);
      wprintf(L"Path Names:\n");
      for (NameIdx = PathName;
        NameIdx[0] != L'\0';
        NameIdx += wcslen(NameIdx) + 1)
      {
        if (':' != NameIdx[1]) {
          wsprintf(DriverPathName, L"%s:", NameIdx);
        }
        else {
          wsprintf(DriverPathName, L"%s", NameIdx);
        }
        wprintf(L"  %s\n", DriverPathName);
        if (0 == wcsncmp(L"\\Device\\HarddiskVolume", DeviceName, 22))
        {
          if (GetDiskFreeSpaceEx(DriverPathName, &available, &total, &free)) {
            wprintf(L"              total: %I64d\n", total.QuadPart);
            wprintf(L"               free: %I64d\n", free.QuadPart);
            wprintf(L"  available to user: %I64d\n", available.QuadPart);
          }
        }
      }
      wprintf(L"\n");
    }
    FindVolumeClose(volHandle);
  }

  return 0;
}

