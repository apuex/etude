#ifndef __FOO__
#define __FOO__
#ifdef DLL_EXPORT
#define FOOAPI __declspec( dllexport )
#else
#define FOOAPI __declspec( dllimport )
#endif
#pragma pack(push, 1)

typedef struct {
    int   c;
    char *a;
    char *b;
} foo;

foo* FOOAPI get_foo();
void FOOAPI cmain();
#pragma pack(pop)
#endif
