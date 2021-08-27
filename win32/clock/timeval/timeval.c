#define UNICODE
#include <windows.h>
#include <stdio.h>
#include <stdint.h>

#define EPOCH_DIFF 116444736000000000 // times 100 nano seconds.

int main(int argc, char *argv[]) {
	FILETIME ft;
	SYSTEMTIME st,lt;
	uint64_t nanosecs;
	time_t ts;
	TIME_ZONE_INFORMATION tz;
	GetTimeZoneInformation(&tz);
	GetSystemTimeAsFileTime(&ft);
	time(&ts);
	nanosecs = ((uint64_t)ft.dwHighDateTime << 32) | ft.dwLowDateTime;
	wprintf(TEXT("sizeof(long) = %zu\n"), sizeof(long));
	wprintf(TEXT("nanosecs = %zu - time_t = %zu => %zu\n"),
		       nanosecs / 10000000,
		       (ts ),
		       (nanosecs / 10000000 - (ts ))
		       );
	wprintf(TEXT("FILETIME(epoch 1601 AD): %lu.%lu\n"), ft.dwHighDateTime, ft.dwLowDateTime);
  ts = (nanosecs - EPOCH_DIFF) / 10000000;
	wprintf(TEXT("time_t = %zu\n"), ts);
	
	GetSystemTime(&st);
	GetLocalTime(&lt);
	wprintf(TEXT("SYSTEMTIME(UTC): %04d-%02d-%02d %02d:%02d:%02d.%03d, Weekday: %d\n"),
			st.wYear,
			st.wMonth,
			st.wDay,
			st.wHour,
			st.wMinute,
			st.wSecond,
			st.wMilliseconds,
			st.wDayOfWeek
			);

	wprintf(TEXT("Local Time(%s): %04d-%02d-%02d %02d:%02d:%02d.%03d, Weekday: %d\n"),
			tz.StandardName,
			lt.wYear,
			lt.wMonth,
			lt.wDay,
			lt.wHour,
			lt.wMinute,
			lt.wSecond,
			lt.wMilliseconds,
			lt.wDayOfWeek
			);

	return 0;
}

