#include <windows.h>
#include <stdio.h>

int main(int argc, char* argv[]) {

#define size 1024+1
  WCHAR buffer[size];

  TIME_ZONE_INFORMATION tz;
  GetTimeZoneInformation(&tz);

  wprintf(L"Bias: %d\n", tz.Bias);
  wprintf(L"StandardBias: %d\n", tz.StandardBias);
  wprintf(L"Standard Date %04d-%02d-%02d %02d:%02d:%02d.%03d %s\n"
    , tz.StandardDate.wYear
    , tz.StandardDate.wMonth
    , tz.StandardDate.wDay
    , tz.StandardDate.wHour
    , tz.StandardDate.wMinute
    , tz.StandardDate.wSecond
    , tz.StandardDate.wMilliseconds
    , tz.StandardName
  );

  wprintf(L"Daylight Date: %04d-%02d-%02d %02d:%02d:%02d.%03d %s\n"
    , tz.DaylightDate.wYear
    , tz.DaylightDate.wMonth
    , tz.DaylightDate.wDay
    , tz.DaylightDate.wHour
    , tz.DaylightDate.wMinute
    , tz.DaylightDate.wSecond
    , tz.DaylightDate.wMilliseconds
    , tz.DaylightName
  );

  {
  LPWSTR pMessage = L"%1!*s! %3!ld!%n"
                    L"%4!*s! %6%n"
                    L"%7!*s! %9!04d!-%10!02d!-%11!02d! %12!02d!:%13!02d!:%14!02d!.%15!03d!%n"
                    L"%16!*s! %18!ld!%n"
                    L"%19!*s! %21%n"
                    L"%22!*s! %24!04d!-%25!02d!-%26!02d! %27!02d!:%28!02d!:%29!02d!.%30!03d!%n"
                    L"%31!*s! %33!ld!";
  DWORD_PTR pArgs[] = {
    (DWORD_PTR)20, (DWORD_PTR)L"Bias:", tz.Bias,
    (DWORD_PTR)20, (DWORD_PTR)L"StandardName:", (DWORD_PTR)tz.StandardName,
    (DWORD_PTR)20, (DWORD_PTR)L"StandardDate:", tz.StandardDate.wYear, tz.StandardDate.wMonth, tz.StandardDate.wDay, tz.StandardDate.wHour, tz.StandardDate.wMinute, tz.StandardDate.wSecond, tz.StandardDate.wMilliseconds,
    (DWORD_PTR)20, (DWORD_PTR)L"StandardBias:", tz.StandardBias,
    (DWORD_PTR)20, (DWORD_PTR)L"DaylightName:", (DWORD_PTR)tz.DaylightName,
    (DWORD_PTR)20, (DWORD_PTR)L"DaylightDate:", tz.DaylightDate.wYear, tz.DaylightDate.wMonth, tz.DaylightDate.wDay, tz.DaylightDate.wHour, tz.DaylightDate.wMinute, tz.DaylightDate.wSecond, tz.DaylightDate.wMilliseconds,
    (DWORD_PTR)20, (DWORD_PTR)L"DaylightBias:", tz.DaylightBias
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
    wprintf(L"Current Timezone:\n%s\n", buffer);
  }
  }

  return 0;
}
