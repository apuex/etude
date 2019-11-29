#include <stdio.h>
#include <stdlib.h>

#define PRICE_LIST_COUNT 2
#define PRICE_LIST_ITEM_COUNT 15
#define ITERATE_COUNT 20

void
print_env (char **env)
{
  for (int i = 0; env[i] != NULL; ++i)
    {
      printf ("%s\n", env[i]);
    }
}

void
print_price_list (int len, double list[])
{
  for (int i = 0; i < len; ++i)
    {
      printf ("%f", list[i]);
      if (i != (len - 1))
	printf (", ");
    }
  printf ("\n");
}

void
print_average_price (int len, double list[])
{
  double price = 0;
  for (int i = 0; i < len; ++i)
    {
      price += list[i];
    }
  price = (price / (len - 1));
  printf ("avarage pricing: %f\n", price);
}

double
calc_price_from_list (int index, int len, double list[])
{
  double price = 0;
  for (int i = 0; i < len; ++i)
    {
      if (i != index)
	price += list[i];
    }
  return (price / (len - 1));
}



int
main (int argc, char *argv[], char *env[])
{

  double price_lists[PRICE_LIST_COUNT][PRICE_LIST_ITEM_COUNT] = {
    {
     849.79,
     776,
     856,
     749,
     692,
     508,
     700,
     618,
     699,
     615,
     828,
     838,
     750,
     800,
     765},
    {}
  };

  print_price_list (PRICE_LIST_ITEM_COUNT, price_lists[0]);
  print_average_price(PRICE_LIST_ITEM_COUNT, price_lists[0]);
  for (int i = 0; i < ITERATE_COUNT; ++i)
    {
      int input = i % 2;
      int output = !input;
      //printf ("%d, %d\n", input, output);

      for (int i = 0; i < PRICE_LIST_ITEM_COUNT; ++i)
	{
	  price_lists[output][i] =
	    calc_price_from_list (i, PRICE_LIST_ITEM_COUNT,
				  price_lists[input]);
	}
      print_price_list (PRICE_LIST_ITEM_COUNT, price_lists[output]);
    }

  return EXIT_SUCCESS;
}
