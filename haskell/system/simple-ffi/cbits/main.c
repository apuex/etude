#include <stdio.h>
#include <stdlib.h>
#include "HsFoo_stub.h"
#include "foo.h"

static foo _the_foo_ = {5, "hello", "world"};

foo * get_foo() {
	return &_the_foo_;
}

void cmain() {  
  foo *f;
  f = malloc(sizeof(foo));
  f->a = "Hello";
  f->b = "World";
  f->c = 55555; 

  printf("foo has been set in C:\n  a: %s\n  b: %s\n  c: %d\n",f->a,f->b,f->c);

  setFoo(f);

  printf("foo has been set in Haskell:\n  a: %s\n  b: %s\n  c: %d\n",f->a,f->b,f->c);

  free_HaskellPtr(f->a);
  free_HaskellPtr(f->b);
  free(f);
}
