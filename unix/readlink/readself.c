#include <limits.h>
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <libgen.h>


int main(int argc, char* argv[]) {
  size_t len = 0;
  char path[PATH_MAX];
  const char *self = "/proc/self/exe";
  char *name;
  
  len = readlink(self, path, sizeof(path));
  path[len] = '\0';

  printf("The realpath of [%s] is [%s]\n", argv[0], path);
  name = basename(path);
  dirname(path);
  printf("The dirname of [%s] is [%s]\n", name, path);
  name = basename(path);
  dirname(path);
  printf("The dirname of [%s] is [%s]\n", name, path);

  return EXIT_SUCCESS;
}
