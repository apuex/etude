#ifndef __MY_LIB__
#define __MY_LIB__

#define MAX_STR_LEN 128

typedef struct {
	int x;
	double y;
} my_foo_t;

typedef struct {
	int x;
	char *y;
	//char y[MAX_STR_LEN];
} my_bar_t;

typedef enum {
	FOO_TYPE,
        BAR_TYPE
} my_data_type_t;

typedef struct {
	my_data_type_t _type;
	union {
		my_foo_t foo;
		my_bar_t bar;
	} _data;
} my_data_t;	

int my_set_foo(my_foo_t * data);
my_foo_t* my_update_foo(my_foo_t * data);
int my_get_bar(my_bar_t * data);
int my_set_data(my_data_t * data);
int my_get_data(my_data_t * data);

#endif //__MY_LIB__
