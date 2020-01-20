// This program needs only the essential Windows header files.
#define WIN32_LEAN_AND_MEAN 1

#include <windows.h>
#include <malloc.h>
#include <stdio.h>
#include <stdlib.h>
#include "perfctrs-enum-objects.h"
#include <pdh.h>
#include <pdhmsg.h>

#pragma comment(lib, "pdh.lib")


int
main (int argc, char *argv[])
{
  pdh_enum_objects(NULL, NULL, &pdh_enum_object_items);

  return EXIT_SUCCESS;
}

