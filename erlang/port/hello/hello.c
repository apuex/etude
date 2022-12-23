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


/* read from stdin */ 
#ifdef WIN32
static int read_exact(byte *buffer, int len)
{
    HANDLE standard_input = GetStdHandle(STD_INPUT_HANDLE);
    
    unsigned read_result;
    unsigned sofar = 0;
    
    if (!len) { /* Happens for "empty packages */
	return 0;
    }
    for (;;) {
	if (!ReadFile(standard_input, buffer + sofar,
		      len - sofar, &read_result, NULL)) {
	    return -1; /* EOF */
	}
	if (!read_result) {
	    return -2; /* Interrupted while reading? */
	}
	sofar += read_result;
	if (sofar == len) {
	    return len;
	}
    }
} 
#elif defined(UNIX)
static int read_exact(byte *buffer, int len) {
    int i, got = 0;
    
    do {
	if ((i = read(0, buffer + got, len - got)) <= 0)
	    return(i);
	got += i;
    } while (got < len);
    return len;
   
}
#endif

int main(int argc, char* argv[]) {
  int term_len = 0;
  int term_idx = 0;
  char term_len_buf[2];
  int state = 0;
  char buff[1];
  if(argc != 2) return EXIT_FAILURE;
  FILE *fp = fopen(argv[1], "w+");
  if(NULL == fp) return EXIT_FAILURE;

#ifdef WIN32
    _setmode(_fileno( stdin),  _O_BINARY);
#endif

  while(1) 
  {
    int n = read_exact(buff, 1);
    if(n > 0) {
      for(int i = 0; i != n && i != sizeof(buff); ++i) {
        fprintf(fp, "%02X ", (0xff & buff[i]));
	switch(state) {
        case 0: term_len_buf[0] = buff[i];
          state = 1;
          break;
        case 1: term_len_buf[1] = buff[i];
          term_len = (0xFFFF & ((term_len_buf[0] << 8) | (term_len_buf[1])));
          term_idx = 0;
          state = 2;
          break;
        case 2:
          term_idx += 1;
          if(term_idx == term_len) {
	    state = 0;
	    fprintf(fp, "\n");
	  }
          break;
        default:
          break;
	}
        fflush(fp);
      }
    } else if( n == 0) {
    } else {
      fprintf(fp, "terminated.\n");
      break;
    }
  }
  fflush(fp);
  fclose(fp);
  return EXIT_SUCCESS;
}

