#include "ring-buffer.hpp"
#include <iostream>

using namespace std;
using namespace apuex;

typedef ring_buffer<char> char_buffer;

int main(int argc, char* argv[]) {
  size_t len = 0;
  char_buffer buffer(64);
  char input[32] = {"hello, world!"};
  char output[32] = {0};
 
  cout << "writting [" << input << "] to buffer" << endl; 
  len = buffer.write(input, sizeof(input));
  cout << len << " bytes written." << endl;

  cout << "writting [" << input << "] to buffer" << endl; 
  len = buffer.write(input, sizeof(input));
  cout << len << " bytes written." << endl;

  cout << "writting [" << input << "] to buffer" << endl; 
  len = buffer.write(input, sizeof(input));
  cout << len << " bytes written." << endl;

  cout << "reading bytes from buffer to output" << endl; 
  len = buffer.read(output, sizeof(output));
  cout << len << " bytes read: [" << output << "]" << endl;

  cout << "reading bytes from buffer to output" << endl; 
  len = buffer.read(output, sizeof(output));
  cout << len << " bytes read: [" << output << "]" << endl;

  cout << "reading bytes from buffer to output" << endl; 
  len = buffer.read(output, sizeof(output));
  cout << len << " bytes read: [" << output << "]" << endl;

  return 0;
}

