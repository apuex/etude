#include <stdio.h>
#include <stdlib.h>
#include "config.h"
#include "version_supp.h"

int main(int argc, char* argv[]) {
    printf("%s\n", PACKAGE_STRING);
    supp();
    return EXIT_SUCCESS;
}
