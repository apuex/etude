#include "mylib.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

static my_bar_t _the_bar = { 0xff, "You god damn bastard!", 2.71828 };
static char _the_version[MAX_STR_LEN]= "1.0.0.0 release";

char MYLIBAPI *my_version() {
	printf("my_version: sizeof(int) -> %zu bytes\n", sizeof(int));
#ifdef __cplusplus
	printf("my_version: compiling with C++\n");
#else
	printf("my_version: compiling with C\n");
#endif
	return _the_version;
}

int MYLIBAPI my_set_foo(my_foo_t * data) {
	printf("my_set_foo: x -> %d, y -> %f\n", data->x, data->y);
	data->x = 0xf;
	data->y = 1234.56789;
	return 0x1;
}

my_foo_t MYLIBAPI *my_update_foo(my_foo_t * data) {
	printf("my_update_foo: x -> %d, y -> %f\n", data->x, data->y);
	data->x = 0xf;
	data->y = 1234.56789;
	return data;
}

int MYLIBAPI my_set_bar(my_bar_t * data) {
	printf("my_set_bar: x -> %d, y -> %f, s -> %s\n", data->x, data->y, data->s);
	return 0x2;
}

my_bar_t MYLIBAPI *my_update_bar(my_bar_t * data) {
	printf("my_update_bar: x -> %d, y -> %f, s -> %s\n", data->x, data->y, data->s);
	return data;
}

my_bar_t MYLIBAPI *my_get_bar() {
	//my_bar_t * p = (my_bar_t*)malloc(sizeof(my_bar_t));
	//memset(p, 0, sizeof(my_bar_t));
	//p->x = 0x1;
	//strcpy(p->s, _the_bar.s);
	//return p;
	return &_the_bar;
}

int MYLIBAPI my_set_data(my_data_t * data) {
	return 0;
}

int MYLIBAPI my_get_data(my_data_t * data) {
	return 0;
}

char MYLIBAPI *my_null_string() {
	return NULL;
}
