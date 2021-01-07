#include <stdlib.h>
#include <stdio.h>
#include <time.h>


int main(int argc, char* argv[]) {
    printf("sizeof(char) = %ld\n", sizeof(char));
    printf("sizeof(short) = %ld\n", sizeof(short));
    printf("sizeof(int) = %ld\n", sizeof(int));
    printf("sizeof(long) = %ld\n", sizeof(long));
    // printf("sizeof(long long) = %ld\n", sizeof(long long));
    printf("sizeof(size_t) = %ld\n", sizeof(size_t));
    printf("sizeof(time_t) = %ld\n", sizeof(time_t));

    return EXIT_SUCCESS;
}
