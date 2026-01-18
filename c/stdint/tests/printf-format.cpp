#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

struct fmt_desc {
  const char name[64];
  int m;
  int c;
};

void format_desc(fmt_desc* fmt) {
  printf(fmt->name, fmt->m, fmt->c);
}

void format_module(int n) {
  fmt_desc descs[] =
  { { "module=%02d, signal=%09d\n", n, 8352001 + ( (n - 1) * 3) }
  , { "module=%02d, signal=%09d\n", n, 8352002 + ( (n - 1) * 3) }
  , { "module=%02d, signal=%09d\n", n, 8352003 + ( (n - 1) * 3) }
  };

  for(size_t i = 0; i != (sizeof(descs)/sizeof(fmt_desc)); ++i) {
    format_desc(&descs[i]);
  }
}

int main(int argc, char* argv[]) {
  if(1 == argc)
  {
    printf("%s <number>\n", argv[0]);
    return EXIT_FAILURE;
  }

  int n = atoi(argv[1]);
  format_module(n);

  return EXIT_SUCCESS;
}

