#include <ctype.h>
#include <stdlib.h>
#include <string.h>
#include <stdio.h>

#ifdef UNIX
#include <unistd.h>
#endif 

#if defined WIN32
#include <windows.h> 
#include <fcntl.h>
#else
#include <sys/types.h>
#endif

#include <limits.h>

#include <ei.h>
#include <erl_interface.h>

int main(int argc, char* argv[]) {
  ETERM *term;
  char term_buf[0xFFFF];
  int index = 0;
  int result = 0;
  int i = 0;

  erl_init(NULL, 0);
  
  term = erl_format("{hello, ~s}", "World");
  result = ei_encode_version(term_buf, &index);
  printf("index = %d, result = %d\r\n", index, result);
  result = ei_encode_term(term_buf, &index, term);
  printf("index = %d, result = %d\r\n", index, result);
  erl_free_term(term);
  
  for(i = 0; i != index; ++i) {
    printf("%02X ", (0xFF & term_buf[i]));
  }
  printf("\r\n");

  return EXIT_SUCCESS;
}

