#include "mylib.h"


int main(int argc, char* argv[]) {
	my_data_t mydata;
	mydata._type = FOO_TYPE;
	mydata.data.foo.x = 1;
	mydata.data.foo.y = 1;

	my_set_data(&mydata);
	my_get_data(&mydata);

	return 0;
}
