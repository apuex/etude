#define UNICODE
#include <windows.h>
#include <stdio.h>


int main(int argc, char *argv[]) {
	FILETIME ft;
	SYSTEMTIME st;
	TIME_ZONE_INFORMATION tz;
	GetTimeZoneInformation(&tz);
	GetSystemTimeAsFileTime(&ft);
	wprintf(TEXT("FILETIME(epoch 1601 AD): %lu.%lu\n"), ft.dwHighDateTime, ft.dwLowDateTime);
	
	GetSystemTime(&st);
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

	GetLocalTime(&st);
	wprintf(TEXT("Local Time(%s): %04d-%02d-%02d %02d:%02d:%02d.%03d, Weekday: %d\n"),
			tz.StandardName,
			st.wYear,
			st.wMonth,
			st.wDay,
			st.wHour,
			st.wMinute,
			st.wSecond,
			st.wMilliseconds,
			st.wDayOfWeek
			);


	return 0;
}

