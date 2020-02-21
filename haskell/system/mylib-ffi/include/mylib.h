#ifndef __MY_LIB__
#define __MY_LIB__
#ifdef MYLIBAPI_EXPORT
#define MYLIBAPI __declspec( dllexport )
#else
#define MYLIBAPI __declspec( dllimport )
#endif
#define MAX_STR_LEN 128

#pragma pack(push, 1)

typedef struct {
	int x;
	double y;
} my_foo_t;

typedef struct {
	int x;
	char y[MAX_STR_LEN];
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

#pragma pack(pop)

char MYLIBAPI *my_version();

int MYLIBAPI my_set_foo(my_foo_t * data);
my_foo_t MYLIBAPI *my_update_foo(my_foo_t * data);
my_bar_t MYLIBAPI *my_get_bar();
int MYLIBAPI my_set_bar(my_bar_t * data);
my_bar_t MYLIBAPI *my_update_bar(my_bar_t * data);
int MYLIBAPI my_set_data(my_data_t * data);
int MYLIBAPI my_get_data(my_data_t * data);

#endif //__MY_LIB__
