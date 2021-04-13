#ifndef __struct_test_included__
#define __struct_test_included__

typedef struct struct_test {
  int  id;
  char name[64];
} struct_test_t;


#ifdef __cplusplus
extern "C" {
#endif

void print_struct_test(struct_test_t * st);

#ifdef __cplusplus
}
#endif

#endif // __struct_test_included__

