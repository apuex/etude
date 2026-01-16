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

HANDLE g_hStopEvent = NULL;
BOOL g_bStopped = FALSE;

BYTE lpReadBuffer[6]; // 2-byte length, 2-byte wRequestID and 2-byte wParam
DWORD dwTotalBytesRead = 0;
BYTE lpWriteBuffer[16]; // 2-byte length, 8-byte ullTimestamp.
DWORD dwTotalBytesWritten = 0;

BOOL
WINAPI
CtrlHandler(DWORD fdwCtrlType)
{
  SetEvent(g_hStopEvent);
  return TRUE;
}

static __inline
BOOL
HandleWallClock
  ( HANDLE hStdOutput
  , WORD wRequestID
  , WORD wParam
  )
{
  BOOL bResult = FALSE;
  FILETIME ft;
  ULONGLONG ullTimeVal;
  ULONGLONG ullTimestamp;

  GetSystemTimeAsFileTime(&ft);
  ullTimeVal = ((LONGLONG)ft.dwHighDateTime << 32) | ft.dwLowDateTime;

  switch(wParam)
  {
  case 0://second
    ullTimestamp = (ullTimeVal - EPOCH_DIFF) / 10000000;
    break;
  case 1://millisecond
    ullTimestamp = (ullTimeVal - EPOCH_DIFF) / 10000;
    break;
  case 2://microsecond
    ullTimestamp = (ullTimeVal - EPOCH_DIFF) / 10;
    break;
  case 3://nanosecond
    ullTimestamp = (ullTimeVal - EPOCH_DIFF) * 100;
    break;
  default://millisecond
    ullTimestamp = (ullTimeVal - EPOCH_DIFF) / 10000;
    break;
  }

  lpWriteBuffer[9] = (ullTimestamp >> 0 & 0xff);
  lpWriteBuffer[8] = (ullTimestamp >> 8 & 0xff);
  lpWriteBuffer[7] = (ullTimestamp >> 16 & 0xff);
  lpWriteBuffer[6] = (ullTimestamp >> 24 & 0xff);
  lpWriteBuffer[5] = (ullTimestamp >> 32 & 0xff);
  lpWriteBuffer[4] = (ullTimestamp >> 40 & 0xff);
  lpWriteBuffer[3] = (ullTimestamp >> 48 & 0xff);
  lpWriteBuffer[2] = (ullTimestamp >> 56 & 0xff);
  lpWriteBuffer[1] = 8;
  lpWriteBuffer[0] = 0;

  bResult = WriteFile
           ( hStdOutput
           , lpWriteBuffer
           , 10 //sizeof(lpWriteBuffer)
           , &dwTotalBytesWritten
           , NULL
           );

  return bResult;
}

static __inline
BOOL
HandleSteadyClock
  ( HANDLE hStdOutput
  , WORD wRequestID
  , WORD wParam
  )
{
  return HandleWallClock(hStdOutput, wRequestID, wParam);
}

static __inline BOOL HandleRequest
  ( HANDLE hStdOutput
  , WORD wRequestID
  , WORD wParam
  )
{
  switch(wRequestID)
  {
  case 0: // get wall clock
    return HandleWallClock(hStdOutput, wRequestID, wParam);
  case 1: // get steady clock
    return HandleSteadyClock(hStdOutput, wRequestID, wParam);
  default:
    return HandleWallClock(hStdOutput, wRequestID, wParam);
  }
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
        if(sizeof(lpReadBuffer) == dwTotalBytesRead)
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

