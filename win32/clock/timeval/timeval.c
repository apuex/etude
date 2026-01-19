#define UNICODE
#include <stdio.h>
#include <time.h>
#include <windows.h>

#define EPOCH_DIFF 116444736000000000 // times 100 nano seconds.

// Compile with 'Microsoft Platform SDK for Windows Server 2003 R2'
// Set Windows XP x64 Build Environment (Retail)
// cl /MD /GS- /O2 /DNDEBUG timeval.c
// cl /MT /GS- /O2 /DNDEBUG timeval.c /link bufferoverflowu.lib

void TimetToFileTime( time_t t, LPFILETIME pft )
{
  LONGLONG ll = Int32x32To64(t, 10000000) + 116444736000000000;
  pft->dwLowDateTime = (DWORD) ll;
  pft->dwHighDateTime = ll >>32;
}

int main(int argc, char *argv[]) {
  FILETIME ft;
  SYSTEMTIME st, lt;
  ULONGLONG nanosecs;
  ULONGLONG unix_time;
  ULONGLONG currentmillis;
  ULONGLONG millsec;
  time_t ts1 = 0x0fffffff00000000;
  TIME_ZONE_INFORMATION tz;

  GetTimeZoneInformation(&tz);
  wprintf(TEXT("Local Time TZ(StandardName=\"%s\", DaylightName=\"%s\", Bias=%d)\n"),
      tz.StandardName,
      tz.DaylightName,
      tz.Bias
      );

  GetSystemTimeAsFileTime(&ft);
  time(&ts1);
  wprintf(TEXT("time(&ts1)       => %Iu\n"), ts1);
  nanosecs = ((LONGLONG)ft.dwHighDateTime << 32) | ft.dwLowDateTime;
  unix_time = (nanosecs - EPOCH_DIFF) / 10000000;
  currentmillis = (nanosecs - EPOCH_DIFF) / 10000;
  //currentmillis = unix_time * 1000;
  millsec = (nanosecs - EPOCH_DIFF) % 10000000;
  wprintf(TEXT("sizeof(long)     = %Iu\n"), sizeof(long));
  wprintf(TEXT("sizeof(size_t)   = %Iu\n"), sizeof(size_t));
  wprintf(TEXT("sizeof(time_t)   = %Iu\n"), sizeof(time_t));
  wprintf(TEXT("sizeof(LONGLONG) = %Iu\n"), sizeof(LONGLONG));
  wprintf(TEXT("nanosecs = %Iu - time_t = %Iu => %Iu\n"),
          nanosecs / 10000000,
          ts1,
          ((nanosecs / 10000000) - ts1));
  wprintf(TEXT("FILETIME(epoch 1601 AD): ft.dwHighDateTime=%Iu, ft.dwLowDateTime=%Iu\n"),
          ft.dwHighDateTime,
          ft.dwLowDateTime);
  wprintf(TEXT("calculated nanosecs  => %Iu\n"), nanosecs);
  wprintf(TEXT("calculated unix_time => %Iu.%Iu\n"), unix_time, millsec);
  wprintf(TEXT("calculated currentmillis => %Iu\n"), currentmillis);

  GetSystemTime(&st);
  GetLocalTime(&lt);
  wprintf(TEXT("SYSTEMTIME(UTC): \"%04d-%02d-%02d %02d:%02d:%02d.%03d\", Weekday: %d\n"),
      st.wYear,
      st.wMonth,
      st.wDay,
      st.wHour,
      st.wMinute,
      st.wSecond,
      st.wMilliseconds,
      st.wDayOfWeek);

  wprintf(TEXT("Local Time TZ(StandardName=\"%s\", DaylightName=\"%s\"): \"%04d-%02d-%02d %02d:%02d:%02d.%03d\", Weekday: %d\n"),
      tz.StandardName,
      tz.DaylightName,
      lt.wYear,
      lt.wMonth,
      lt.wDay,
      lt.wHour,
      lt.wMinute,
      lt.wSecond,
      lt.wMilliseconds,
      lt.wDayOfWeek);

  return 0;
}

