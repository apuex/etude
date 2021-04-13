#include <stdio.h>
#include <struct-test.h>

void print_struct_test(struct_test_t * st) {
  printf("struct_test { id=%d, name=\"%s\" }\n", st->id, st->name);
}


