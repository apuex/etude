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

  cout << "[BEFORE]"
     << ": buffer_size=" << buffer.buffer_size()
     << ", element_count=" << buffer.element_count()
     << ", read_pos=" << buffer.read_pos()
     << ", write_pos=" << buffer.write_pos()
     << endl;
  cout << "writting [" << input << "] to buffer..";
  len = buffer.write(input, sizeof(input));
  cout << len << " bytes written." << endl;
  cout << "[AFTER]"
     << ": buffer_size=" << buffer.buffer_size()
     << ", element_count=" << buffer.element_count()
     << ", read_pos=" << buffer.read_pos()
     << ", write_pos=" << buffer.write_pos()
     << endl
     << endl;

  cout << "[BEFORE]"
     << ": buffer_size=" << buffer.buffer_size()
     << ", element_count=" << buffer.element_count()
     << ", read_pos=" << buffer.read_pos()
     << ", write_pos=" << buffer.write_pos()
     << endl;
  cout << "reading bytes from buffer to output..";
  len = buffer.read(output, sizeof(output));
  cout << len << " bytes read: [" << output << "]" << endl;
  cout << "[AFTER]"
     << ": buffer_size=" << buffer.buffer_size()
     << ", element_count=" << buffer.element_count()
     << ", read_pos=" << buffer.read_pos()
     << ", write_pos=" << buffer.write_pos()
     << endl
     << endl;

  cout << "[BEFORE]"
     << ": buffer_size=" << buffer.buffer_size()
     << ", element_count=" << buffer.element_count()
     << ", read_pos=" << buffer.read_pos()
     << ", write_pos=" << buffer.write_pos()
     << endl;
  cout << "writting [" << input << "] to buffer..";
  len = buffer.write(input, sizeof(input));
  cout << len << " bytes written." << endl;
  cout << "[AFTER]"
     << ": buffer_size=" << buffer.buffer_size()
     << ", element_count=" << buffer.element_count()
     << ", read_pos=" << buffer.read_pos()
     << ", write_pos=" << buffer.write_pos()
     << endl
     << endl;

  cout << "[BEFORE]"
     << ": buffer_size=" << buffer.buffer_size()
     << ", element_count=" << buffer.element_count()
     << ", read_pos=" << buffer.read_pos()
     << ", write_pos=" << buffer.write_pos()
     << endl;
  cout << "reading bytes from buffer to output..";
  len = buffer.read(output, sizeof(output));
  cout << len << " bytes read: [" << output << "]" << endl;
  cout << "[AFTER]"
     << ": buffer_size=" << buffer.buffer_size()
     << ", element_count=" << buffer.element_count()
     << ", read_pos=" << buffer.read_pos()
     << ", write_pos=" << buffer.write_pos()
     << endl
     << endl;

  cout << "[BEFORE]"
     << ": buffer_size=" << buffer.buffer_size()
     << ", element_count=" << buffer.element_count()
     << ", read_pos=" << buffer.read_pos()
     << ", write_pos=" << buffer.write_pos()
     << endl;
  cout << "writting [" << input << "] to buffer..";
  len = buffer.write(input, sizeof(input));
  cout << len << " bytes written." << endl;
  cout << "[AFTER]"
     << ": buffer_size=" << buffer.buffer_size()
     << ", element_count=" << buffer.element_count()
     << ", read_pos=" << buffer.read_pos()
     << ", write_pos=" << buffer.write_pos()
     << endl
     << endl;

  cout << "[BEFORE]"
     << ": buffer_size=" << buffer.buffer_size()
     << ", element_count=" << buffer.element_count()
     << ", read_pos=" << buffer.read_pos()
     << ", write_pos=" << buffer.write_pos()
     << endl;
  cout << "reading bytes from buffer to output..";
  len = buffer.read(output, sizeof(output));
  cout << len << " bytes read: [" << output << "]" << endl;
  cout << "[AFTER]"
     << ": buffer_size=" << buffer.buffer_size()
     << ", element_count=" << buffer.element_count()
     << ", read_pos=" << buffer.read_pos()
     << ", write_pos=" << buffer.write_pos()
     << endl
     << endl;

  return 0;
}

