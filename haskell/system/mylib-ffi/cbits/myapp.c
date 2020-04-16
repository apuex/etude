#include "mylib.h"
#include <stdio.h>

int main(int argc, char* argv[]) {
	my_data_t mydata;
	mydata._type = FOO_TYPE;
	mydata._data.foo.x = 1;
	mydata._data.foo.y = 1;

	my_set_data(&mydata);
	my_get_data(&mydata);
	
	printf("%s\n", my_version());
	printf("my_bar: x -> %d, y -> %f, s -> %s\n", my_get_bar()->x, my_get_bar()->y, my_get_bar()->s);
	
	return 0;
}
