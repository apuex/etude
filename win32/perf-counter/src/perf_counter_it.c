/*  =========================================================================
    perf_counter_it - performance counter enumerator

    Copyright (c) the Authors
    =========================================================================
*/

/*
@header
    perf_counter_it - performance counter enumerator
@discuss
@end
*/

#include "perf_counter_classes.h"

int main (int argc, char *argv [])
{
    bool verbose = false;
    int argn;
    for (argn = 1; argn < argc; argn++) {
        if (streq (argv [argn], "--help")
        ||  streq (argv [argn], "-h")) {
            puts ("perf-counter-it [options] ...");
            puts ("  --verbose / -v         verbose test output");
            puts ("  --help / -h            this information");
            return 0;
        }
        else
        if (streq (argv [argn], "--verbose")
        ||  streq (argv [argn], "-v"))
            verbose = true;
        else {
            printf ("Unknown option: %s\n", argv [argn]);
            return 1;
        }
    }
    //  Insert main code here
    if (verbose)
        zsys_info ("perf_counter_it - performance counter enumerator");
    return 0;
}
