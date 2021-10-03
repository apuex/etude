#include <stdlib.h>
#include <stdio.h>
#include <time.h>


int main(int argc, char* argv[]) {
    printf("sizeof(char) = %llu\n", sizeof(char));
    printf("sizeof(short) = %llu\n", sizeof(short));
    printf("sizeof(int) = %llu\n", sizeof(int));
    printf("sizeof(long) = %llu\n", sizeof(long));
    // printf("sizeof(long long) = %ld\n", sizeof(long long));
    printf("sizeof(size_t) = %llu\n", sizeof(size_t));
    printf("sizeof(time_t) = %llu\n", sizeof(time_t));

    return EXIT_SUCCESS;
}
