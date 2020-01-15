#include <stdio.h>
#include <stdlib.h>
#include <getopt.h>
#include <string.h>
#include <sys/time.h>
#include <sys/types.h>
#include <unistd.h>

void
help (char *cmd)
{
  fprintf (stderr, "Usage: %s [-k key] [-t nsecs]\n", cmd);
}

void
version ()
{
  fprintf (stderr, "cat with keep alive version 1.0.0.\n");
}

int
main (int argc, char *argv[])
{
  fd_set rfds;
  struct timeval tv;
  int retval;
  int nsecs = 5;
  char key[128];
  int c;
  int digit_optind = 0;

  while (1)
    {
      int this_option_optind = optind ? optind : 1;
      int option_index = 0;
      static struct option long_options[] = {
	{"key", required_argument, 0, 'k'},
	{"timeout", required_argument, 0, 't'},
	{"version", no_argument, 0, 'v'},
	{"help", no_argument, 0, 'h'},
	{0, 0, 0, 0}
      };

      c = getopt_long (argc, argv, "k:t:vh", long_options, &option_index);
      if (c == -1)
	break;

      switch (c)
	{
	case 'k':
	  if (strlen (optarg) > 128)
	    {
	      exit (EXIT_FAILURE);
	    }
	  else
	    {
	      strncpy (key, optarg, 128);
	    }
	  break;

	case 't':
	  nsecs = atoi (optarg);
	  break;

	case 'h':
	  help (argv[0]);
	  exit (EXIT_SUCCESS);

	case 'v':
	  version ();
	  exit (EXIT_SUCCESS);
	  break;

	default:
	  printf ("?? getopt returned character code 0%o ??\n", c);
	  exit (EXIT_FAILURE);
	}
    }

  if (optind < argc)
    {
      printf ("non-option ARGV-elements: ");
      while (optind < argc)
	printf ("%s ", argv[optind++]);
      printf ("\n");
      exit (EXIT_FAILURE);
    }


  /* Watch stdin (fd 0) to see when it has input. */
  setvbuf(stdout, NULL, _IONBF, 0);
  while (1)
    {

      FD_ZERO (&rfds);
      FD_SET (0, &rfds);

      /* Wait up to five seconds. */

      tv.tv_sec = nsecs;
      tv.tv_usec = 0;

      retval = select (1, &rfds, NULL, NULL, &tv);
      /* Don't rely on the value of tv now! */

      if (retval == -1)
	perror ("select()");
      else if (retval)
	{
	  /* FD_ISSET(0, &rfds) will be true. */

	  char *line = NULL;
	  size_t len = 0;
	  ssize_t nread = getline (&line, &len, stdin);
	  if (nread > 0)
	    {
	      if (printf ("[%s] %s\n", key, line) == -1)
		{
		  exit (EXIT_FAILURE);
		}
	      free (line);
	    }
	  else
	    {
	      printf("[%s] nread = %d\n", key, nread);
	    }
	}
      else
	{
	  if (printf ("[%s] %s\n", key, "[keep alive]") == -1)
	    {
	      exit (EXIT_FAILURE);
	    }
	}
    }

  exit (EXIT_SUCCESS);
}
