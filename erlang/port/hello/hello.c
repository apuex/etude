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

#ifdef PRINT_TERM 
#include <ei.h>
#include <erl_interface.h>
#endif

/* read from stdin */ 
#ifdef WIN32
static int read_exact(byte *buffer, int len)
{
    HANDLE standard_input = GetStdHandle(STD_INPUT_HANDLE);
#ifdef ECHO
    HANDLE standard_output = GetStdHandle(STD_OUTPUT_HANDLE);
    
    unsigned write_result;
#endif
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
#ifdef ECHO
	    if (!WriteFile(standard_output, buffer,
			len, &write_result, NULL)) {
		//return -1; /* EOF */
  	    }
#endif
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
  int version = 0;
  int term_len = 0;
  int term_idx = 0;
  char term_buf[0xFFFF];
  int state = 0;
  char buff[1];
  FILE *fp;
  if(argc != 2) return EXIT_FAILURE;
  fp = fopen(argv[1], "ab");
  if(NULL == fp) return EXIT_FAILURE;

#ifdef WIN32
    _setmode(_fileno( stdin),  _O_BINARY);
#endif
#ifdef PRINT_TERM 
  erl_init(NULL, 0);
#endif

  while(1) 
  {
    int i, n;
    n = read_exact(buff, 1);
    if(n > 0) {
      for(i = 0; i != n && i != sizeof(buff); ++i) {
        fprintf(fp, "%02X ", (0xff & buff[i]));
	// fprintf(fp, "state = %d, term_idx = %d, n = %d, i = %d.\r\n", state, term_idx, n, i);
	switch(state) {
        case 0: term_buf[0] = buff[i];
          state = 1;
          break;
        case 1: term_buf[1] = buff[i];
          term_len = (0xFFFF & ((term_buf[0] << 8) | (term_buf[1])));
          term_idx = 0;
          state = 2;
          break;
        case 2: term_buf[term_idx + 2] = buff[i];
          term_idx += 1;
          if(term_idx == term_len) {
            int index = 2;
	    state = 0;
#ifdef PRINT_TERM 
	    fprintf(fp, "=> ");
	    ei_decode_version(term_buf, &index, &version);
	    ei_print_term(fp, term_buf, &index);
#endif
	    fprintf(fp, "\r\n");
            fflush(fp);
	  }
          break;
        default:
	  fprintf(fp, "\r\nstate = %d\r\n", state);
	  state = 0;
          term_idx = 0;
          break;
	}
        fflush(fp);
      }
    } else if( n == 0) {
    } else {
      fprintf(fp, "terminated.\r\n");
      break;
    }
  }
  fflush(fp);
  fclose(fp);
  return EXIT_SUCCESS;
}

