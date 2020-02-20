#include "mylib.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

static my_bar_t _the_bar = { 0xff, "You god damn bastard!"};

char *my_version() {
	printf("my_version: sizeof(int) -> %u bytes\n", sizeof(int));
	return "1.0.0.0 release";
}

int my_set_foo(my_foo_t * data) {
	printf("my_set_foo: x -> %d, y -> %f\n", data->x, data->y);
	data->x = 0xf;
	data->y = 1234.56789;
	return 0x1;
}

my_foo_t* my_update_foo(my_foo_t * data) {
	printf("my_update_foo: x -> %d, y -> %f\n", data->x, data->y);
	data->x = 0xf;
	data->y = 1234.56789;
	return data;
}

int my_set_bar(my_bar_t * data) {
	printf("my_set_bar: x -> %d, y -> %s\n", data->x, data->y);
	return 0x2;
}

my_bar_t* my_update_bar(my_bar_t * data) {
	printf("my_update_bar: x -> %d, y -> %s\n", data->x, data->y);
	return data;
}

my_bar_t* my_get_bar() {
	my_bar_t * p = malloc(sizeof(my_bar_t));
	memset(p, 0, sizeof(my_bar_t));
	p->x = 0x1;
	strcpy(p->y, _the_bar.y);
	return p;
	//return &_the_bar;
}

int my_set_data(my_data_t * data) {
	return 0;
}

int my_get_data(my_data_t * data) {
	return 0;
}

