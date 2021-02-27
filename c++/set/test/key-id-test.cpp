#include "assert.h"
#include "stdio.h"
#include "key.h"

int my_assert(int v, const char* s) {
  if(v) {
    fprintf(stderr, "%s - pass\n", s);
  } else {
    fprintf(stderr, "%s - fail\n", s);
  }
  return v;
}

int test_equal1() {
  key k1(1,1);
  key k2(1,1);
  return (k1 == k2);
}

int test_equal2() {
  key k1(1,0);
  key k2(1,1);
  return !(k1 == k2);
}

int test_less1() {
  key k1(1,1);
  key k2(1,2);
  return (k1 < k2);
}

int test_less2() {
  key k1(1,1);
  key k2(2,1);
  return (k1 < k2);
}

int test_less3() {
  key k1(2,1);
  key k2(1,2);
  return !(k1 < k2);
}

int test_less4() {
  key k1(1,1);
  key k2(1,1);
  return !(k1 < k2);
}

int main(int argc, char* argv[], char* env[]) {
  my_assert(test_equal1(), "equal1 test");
  my_assert(test_equal2(), "equal2 test");
  my_assert(test_less1(), "less1 test");
  my_assert(test_less2(), "less2 test");
  my_assert(test_less3(), "less3 test");
  my_assert(test_less4(), "less4 test");

  return 1;
}

