#ifndef __FOO__
#define __FOO__
#if defined(_WINDLL) || defined(WIN32)
#ifdef DLL_EXPORT
#define FOOAPI __declspec( dllexport )
#else
#define FOOAPI __declspec( dllimport )
#endif
#else
#define FOOAPI
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
