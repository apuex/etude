// This program needs only the essential Windows header files.
#define WIN32_LEAN_AND_MEAN 1

#include <windows.h>
#include <malloc.h>
#include <stdio.h>
#include <pdh.h>
#include <pdhmsg.h>

#pragma comment(lib, "pdh.lib")

CONST PWSTR COUNTER_OBJECT = L"Processor Information";

int main(int argc, char* argv[])
{
    PDH_STATUS status = ERROR_SUCCESS;
    LPWSTR pwsCounterListBuffer = NULL;
    DWORD dwCounterListSize = 0;
    LPWSTR pwsInstanceListBuffer = NULL;
    DWORD dwInstanceListSize = 0;
    LPWSTR pTemp = NULL;

    // Determine the required buffer size for the data. 
    status = PdhEnumObjectItems(
        NULL,                   // real-time source
        NULL,                   // local machine
        COUNTER_OBJECT,         // object to enumerate
        pwsCounterListBuffer,   // pass NULL and 0
        &dwCounterListSize,     // to get required buffer size
        pwsInstanceListBuffer, 
        &dwInstanceListSize, 
        PERF_DETAIL_WIZARD,     // counter detail level
        0); 

    if (status == PDH_MORE_DATA) 
    {
        // Allocate the buffers and try the call again.
        pwsCounterListBuffer = (LPWSTR)malloc(dwCounterListSize * sizeof(WCHAR));
        pwsInstanceListBuffer = (LPWSTR)malloc(dwInstanceListSize * sizeof(WCHAR));

        if (NULL != pwsCounterListBuffer && NULL != pwsInstanceListBuffer) 
        {
            status = PdhEnumObjectItems(
                NULL,                   // real-time source
                NULL,                   // local machine
                COUNTER_OBJECT,         // object to enumerate
                pwsCounterListBuffer, 
                &dwCounterListSize,
                pwsInstanceListBuffer, 
                &dwInstanceListSize, 
                PERF_DETAIL_WIZARD,     // counter detail level
                0); 
     
            if (status == ERROR_SUCCESS) 
            {
                wprintf(L"Counters that the Process objects defines:\n\n");

                // Walk the counters list. The list can contain one
                // or more null-terminated strings. The list is terminated
                // using two null-terminator characters.
                for (pTemp = pwsCounterListBuffer; *pTemp != 0; pTemp += wcslen(pTemp) + 1) 
                {
                     wprintf(L"%s\n", pTemp);
                }

                wprintf(L"\nInstances of the Process object:\n\n");

                // Walk the instance list. The list can contain one
                // or more null-terminated strings. The list is terminated
                // using two null-terminator characters.
                for (pTemp = pwsInstanceListBuffer; *pTemp != 0; pTemp += wcslen(pTemp) + 1) 
                {
                     wprintf(L"%s\n", pTemp);
                }
            }
            else 
            {
                wprintf(L"Second PdhEnumObjectItems failed with %0x%x.\n", status);
            }
        } 
        else 
        {
            wprintf(L"Unable to allocate buffers.\n");
            status = ERROR_OUTOFMEMORY;
        }
    } 
    else 
    {
        wprintf(L"\nPdhEnumObjectItems failed with 0x%x.\n", status);
    }

    if (pwsCounterListBuffer != NULL) 
        free (pwsCounterListBuffer);

    if (pwsInstanceListBuffer != NULL) 
        free (pwsInstanceListBuffer);
}
