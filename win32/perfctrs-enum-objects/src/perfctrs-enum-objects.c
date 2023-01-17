// This program needs only the essential Windows header files.
#define WIN32_LEAN_AND_MEAN 1

#include <windows.h>
#include <malloc.h>
#include <stdio.h>
#include <stdlib.h>
#include "perfctrs-enum-objects.h"
#include <pdh.h>
#include <pdhmsg.h>

void
pdh_enum_objects(
		LPCWSTR szDataSource,
		LPCWSTR szMachineName,
		pdh_enum_object_items_cb_t pEnumItemsFun
		) {
  PDH_STATUS status = ERROR_SUCCESS;

  PZZWSTR mszObjectNameList = NULL;
  DWORD cchBufferSize = 0;
  DWORD dwDetailLevel = PERF_DETAIL_WIZARD;
  BOOL bRefresh = TRUE;
  LPWSTR pObjectName;

  status = PdhEnumObjects (NULL,
			   NULL,
			   mszObjectNameList,
			   &cchBufferSize, dwDetailLevel, bRefresh);

  if (PDH_MORE_DATA == status)
    {
      mszObjectNameList = (PZZWSTR) malloc (cchBufferSize * sizeof (WCHAR));
      if (NULL != mszObjectNameList)
	{
	  status = PdhEnumObjects (NULL,
				   NULL,
				   mszObjectNameList,
				   &cchBufferSize, dwDetailLevel, bRefresh);
	  if (status == ERROR_SUCCESS)
	    {
	      for (pObjectName = mszObjectNameList; *pObjectName != 0;
		   pObjectName += wcslen (pObjectName) + 1)
		{
		  wprintf (L"%s\n", pObjectName);
                  pEnumItemsFun(pObjectName);
		}
	    }
	  else
	    {
              wprintf (L"PdhEnumObjects: 0x%8lx\n", status);
	    } // if (status == ERROR_SUCCESS)
	}
      else
        {
          wprintf (L"malloc: 0x%08p\n", (void*)mszObjectNameList);
        } // if ( NULL != mszObjectNameList ) 
    } // if (PDH_MORE_DATA == status)

}
