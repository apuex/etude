#ifndef UNICODE
#define UNICODE
#endif

#include <windows.h>
#include <stdio.h>
#include <fcntl.h>
#include <io.h>
#include <shellapi.h>
#include <tchar.h>

#define EPOCH_DIFF 116444736000000000 // times 100 nano seconds.

static HANDLE g_hStopEvent = NULL;
static BOOL g_bStopped = FALSE;

static LARGE_INTEGER g_PerfFrequency = {0};
static LARGE_INTEGER g_PerfCounterStart = {0};

static BYTE lpReadBuffer[8] = {0}; // 2-byte length, 2-byte wRequestID and 2-byte wParam
static DWORD dwTotalBytesRead = 0;
static BYTE lpWriteBuffer[64] = {0}; // 2-byte length, 8-byte ullTimestamp.
static DWORD dwTotalBytesWritten = 0;

BOOL
WINAPI
CtrlHandler(DWORD fdwCtrlType)
{
  SetEvent(g_hStopEvent);
  return TRUE;
}

static __inline
ULONGLONG
GetWallClockNano()
{
  FILETIME ft;
  ULONGLONG ullTimeVal;

  GetSystemTimeAsFileTime(&ft);
  ullTimeVal = ((LONGLONG)ft.dwHighDateTime << 32) | ft.dwLowDateTime;
  return (ullTimeVal - EPOCH_DIFF) * 100;
}

static __inline
ULONGLONG
GetSteadyClockNano()
{
  LARGE_INTEGER now;

  QueryPerformanceCounter(&now);
  return (now.QuadPart / (g_PerfFrequency.QuadPart / 1000000000.0f));
}

static __inline
BOOL
HandleRequest
  ( HANDLE hStdOutput
  , WORD wRequestID
  , WORD wParam
  )
{
  BOOL bResult = FALSE;
  ULONGLONG ullTimeVal = 0;
  ULONGLONG ullTimestamp = 0;
  WORD wSize = 8;

  switch(wRequestID)
  {
    case 0:
      ullTimeVal = GetWallClockNano();
      break;
    case 1:
      ullTimeVal = GetSteadyClockNano();
      break;
    case 2:
      {
        int bytes = 0;
        SYSTEMTIME st;
        GetSystemTime(&st);
        bytes = sprintf((lpWriteBuffer + 2),
          "%04d-%02d-%02d %02d:%02d:%02d.%03dZ",
          st.wYear,
          st.wMonth,
          st.wDay,
          st.wHour,
          st.wMinute,
          st.wSecond,
          st.wMilliseconds
          );
        if(0 < bytes)
        {
          wSize = (0xffff & bytes);
        }
      }
      break;
    default:
      ullTimeVal = GetWallClockNano();
      break;
  }

  switch(wParam)
  {
  case 0://second
    ullTimestamp = ullTimeVal / 1000000000;
    break;
  case 1://millisecond
    ullTimestamp = ullTimeVal / 1000000;
    break;
  case 2://microsecond
    ullTimestamp = ullTimeVal / 1000;
    break;
  case 3://nanosecond
    ullTimestamp = ullTimeVal;
    break;
  default:// to nothing.
    break;
  }

  if(2 > wRequestID || 2 < wRequestID)
  {
    lpWriteBuffer[9] = (ullTimestamp >> 0 & 0xff);
    lpWriteBuffer[8] = (ullTimestamp >> 8 & 0xff);
    lpWriteBuffer[7] = (ullTimestamp >> 16 & 0xff);
    lpWriteBuffer[6] = (ullTimestamp >> 24 & 0xff);
    lpWriteBuffer[5] = (ullTimestamp >> 32 & 0xff);
    lpWriteBuffer[4] = (ullTimestamp >> 40 & 0xff);
    lpWriteBuffer[3] = (ullTimestamp >> 48 & 0xff);
    lpWriteBuffer[2] = (ullTimestamp >> 56 & 0xff);
  }
  else
  {
  }
  lpWriteBuffer[1] = (wSize >> 0 & 0xff);
  lpWriteBuffer[0] = (wSize >> 8 & 0xff);;

  bResult = WriteFile
           ( hStdOutput
           , lpWriteBuffer
           , (wSize + 2)
           , &dwTotalBytesWritten
           , NULL
           );

  return bResult;
}

void
WaitStdIO
  ( DWORD dwMilliseconds
  )
{
  HANDLE hStdInput = GetStdHandle(STD_INPUT_HANDLE);
  HANDLE hStdOutput = GetStdHandle(STD_OUTPUT_HANDLE);

  HANDLE handles[2];
  handles[0] = hStdInput;
  handles[1] = g_hStopEvent;

  dwTotalBytesRead = 0;
  while(!g_bStopped)
  {
    DWORD dwBytesRead = 0;
    switch(WaitForMultipleObjects(2, handles, FALSE, dwMilliseconds))
    {
    case WAIT_OBJECT_0:
      if(ReadFile( hStdInput
                 , (lpReadBuffer + dwTotalBytesRead)
                 , (sizeof(lpReadBuffer) - dwTotalBytesRead)
                 , &dwBytesRead
                 , NULL
                 )
         )
      {
        if (0 == dwBytesRead) {
          g_bStopped = TRUE;  // EOF
          break;
        }

        dwTotalBytesRead += dwBytesRead;
        if(6 == dwTotalBytesRead)
        {
          // already read the request message.
          // process request.
          WORD wLength = (lpReadBuffer[0] << 8 | lpReadBuffer[1]);
          WORD wRequestID = (lpReadBuffer[2] << 8 | lpReadBuffer[3]);
          WORD wParam = (lpReadBuffer[4] << 8 | lpReadBuffer[5]);
          BOOL bResult = FALSE;
          dwTotalBytesRead = 0;
          if(4 == wLength)
          {
            bResult = HandleRequest(hStdOutput, wRequestID, wParam);
            if(bResult)
            {
              // success written
            }
            else
            {
              // write failed.
              g_bStopped = TRUE;
            }
          }
          else
          {
            // length error.
            g_bStopped = TRUE;
          }
        }
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

  QueryPerformanceCounter(&g_PerfCounterStart);
  if(!QueryPerformanceFrequency(&g_PerfFrequency))
  {
    g_PerfFrequency.QuadPart = 1;
  };

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

