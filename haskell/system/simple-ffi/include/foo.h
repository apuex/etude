#ifndef __FOO__
#define __FOO__
#pragma pack(push, 1)

typedef struct {
    int   c;
    char *a;
    char *b;
} foo;

foo* get_foo();
void cmain();
#pragma pop
#endif
