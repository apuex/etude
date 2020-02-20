#include "mylib.h"
#include <stdio.h>
#include <math.h>

int my_set_foo(my_foo_t * data) {
	printf("my_set_foo: x -> %d, y -> %f\n", data->x, data->y);
	data->x = 0xbabe;
	data->y = 1234.56789;
	return 0xcafe;
}

my_foo_t* my_update_foo(my_foo_t * data) {
	printf("my_update_foo: x -> %d, y -> %f\n", data->x, data->y);
	data->x = 0xbabe;
	data->y = 1234.56789;
	return data;
}

int my_get_bar(my_bar_t * data) {
	printf("x -> %d, y -> %s\n", data->x, data->y);
	return 0xcafe;
}

int my_set_data(my_data_t * data) {
	return 0;
}

int my_get_data(my_data_t * data) {
	return 0;
}

