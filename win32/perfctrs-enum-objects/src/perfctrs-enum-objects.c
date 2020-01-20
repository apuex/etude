// This program needs only the essential Windows header files.
#define WIN32_LEAN_AND_MEAN 1

#include <windows.h>
#include <malloc.h>
#include <stdio.h>
#include <pdh.h>
#include <pdhmsg.h>

#pragma comment(lib, "pdh.lib")


int
main (int argc, char *argv[])
{
  PDH_STATUS status = ERROR_SUCCESS;

  PZZWSTR mszObjectList = NULL;
  DWORD cchBufferSize = 0;
  DWORD dwDetailLevel = PERF_DETAIL_WIZARD;
  BOOL bRefresh = TRUE;

  status = PdhEnumObjects (NULL,
			   NULL,
			   mszObjectList,
			   &cchBufferSize, dwDetailLevel, bRefresh);

  printf ("status = 0x%8lx\n", status);
  printf ("cchBufferSize = 0x%8lx\n", cchBufferSize);

  if (PDH_MORE_DATA == status)
    {
      mszObjectList = (PZZWSTR) malloc (cchBufferSize * sizeof (WCHAR));
      if (NULL != mszObjectList)
	{
	  status = PdhEnumObjects (NULL,
				   NULL,
				   mszObjectList,
				   &cchBufferSize, dwDetailLevel, bRefresh);

	  if (status == ERROR_SUCCESS)
	    {
	      for (LPWSTR pTemp = mszObjectList; *pTemp != 0;
		   pTemp += wcslen (pTemp) + 1)
		{
		  wprintf (L"%s\n", pTemp);
		}
	    }
	  else
	    {			// if ( NULL != mszObjectList ) 

	    }
	}
    }
  return 0;
}

