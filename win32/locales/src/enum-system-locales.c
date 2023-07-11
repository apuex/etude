#include <windows.h>
#include <stdio.h>
#include <tchar.h>
#include <wchar.h>

// Get-WinSystemLocale
BOOL CALLBACK EnumLocalesProc(
  _In_ LPTSTR lpLocaleString
) {
  _tprintf(_T("  %s\n"), lpLocaleString);
  return TRUE;
}


int main(int argc, char* argv[]) {
  _tprintf(_T("LCID_INSTALLED\n"));
  EnumSystemLocales(
      &EnumLocalesProc,
      LCID_INSTALLED
      );

  _tprintf(_T("LCID_SUPPORTED\n"));
  EnumSystemLocales(
      &EnumLocalesProc,
      LCID_SUPPORTED
      );

  _tprintf(_T("LCID_ALTERNATE_SORTS\n"));
  EnumSystemLocales(
      &EnumLocalesProc,
      LCID_ALTERNATE_SORTS
      );
  return 0;
}
