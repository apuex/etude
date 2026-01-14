#ifndef UNICODE
#define UNICODE
#endif

#include <windows.h>
#include <stdio.h>
#include <fcntl.h>
#include <io.h>
#include <shellapi.h>
#include <tchar.h>

HANDLE g_hStopEvent = NULL;
BOOL g_bStopped = FALSE;


BOOL
WINAPI
CtrlHandler(DWORD fdwCtrlType)
{
  SetEvent(g_hStopEvent);
  return TRUE;
}

void
WaitStdIO
( DWORD dwMilliseconds
)
{
  BYTE lpBuffer[0xffff];
  DWORD dwBytesRead = 0;
  DWORD dwBytesWritten = 0;
  HANDLE hStdInput = GetStdHandle(STD_INPUT_HANDLE);
  HANDLE hStdOutput = GetStdHandle(STD_OUTPUT_HANDLE);

  HANDLE handles[2];
  handles[0] = hStdInput;
  handles[1] = g_hStopEvent;

  while(!g_bStopped)
  {
    switch(WaitForMultipleObjects(2, handles, FALSE, dwMilliseconds))
    {
    case WAIT_OBJECT_0:
      if(ReadFile(hStdInput, lpBuffer, sizeof(lpBuffer), &dwBytesRead, NULL))
      {
        // TODO: parse request
      }
      else
      {
        g_bStopped = TRUE;
      }
      break;
    case WAIT_TIMEOUT:
      break;
    case (WAIT_OBJECT_0 + 1):
      g_bStopped = TRUE;
      break;
    case WAIT_ABANDONED:
    case WAIT_FAILED:
    default:
      g_bStopped = TRUE;
      break;
    }
  }
  CloseHandle(hStdInput);
  CloseHandle(hStdOutput);
}

int
WINAPI
wWinMain
( HINSTANCE hInstance
, HINSTANCE hPrevInstance
, PWSTR lpCmdLine
, int nCmdShow
)
{
  DWORD dwMilliseconds = INFINITE;

  int argc = 0;
  LPWSTR* argv = CommandLineToArgvW(lpCmdLine, &argc);
  if(argc > 1)
  {
    dwMilliseconds = _wtol(argv[1]);
  }

  g_hStopEvent = CreateEvent(NULL, TRUE, FALSE, _T("StopEvent"));

  if(NULL == g_hStopEvent)
  {
      return 0;
  }

  if (SetConsoleCtrlHandler(CtrlHandler, TRUE))
  {
    WaitStdIO(dwMilliseconds);
  }
  else
  {
  }
  CloseHandle(g_hStopEvent);

  return 0;
}

