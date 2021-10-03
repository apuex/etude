#ifndef __APUEX_RING_BUFFER_CXX_INCLUDED_
#define __APUEX_RING_BUFFER_CXX_INCLUDED_

#include <cstddef>

namespace apuex {

template <typename T>
class ring_buffer {
 public:
  typedef T value_type;
  ring_buffer(size_t size)
     : buffer_size(size)
     , buffer(new value_type[size])
     , element_count(0)
     , rd_pos(0)
     , wr_pos(0) 
     { }
  virtual ~ring_buffer() { delete[] buffer; }

  size_t read(value_type* rbuf, size_t to_read) {
    if(0 == element_count) return 0;
    else {
      size_t i = 0;
      for(i = 0; i != to_read && i != element_count; ++i) {
        *(rbuf + i) = *(buffer + rd_pos); ++rd_pos;
        if(buffer_size == rd_pos) rd_pos = 0;
      }
      element_count -= i;
      return i;
    }
  }

  size_t write(const value_type* const wbuf, size_t to_write) {
    if(buffer_size == element_count) return 0;
    else {
      size_t i = 0;
      for(i = 0; i != to_write && i != (buffer_size - element_count); ++i) {
        *(buffer + wr_pos) = *(wbuf + i); ++wr_pos;
        if(buffer_size == wr_pos) wr_pos = 0;
      }
      element_count += i;
      return i;
    }
  }

 private:
  ring_buffer(const ring_buffer& rv) { }
  ring_buffer& operator=(const ring_buffer& rv) { return *this; }
  bool operator==(const ring_buffer& rv) const { return false; }

 private:
  const size_t buffer_size;
  value_type* buffer;
  size_t element_count;
  size_t rd_pos;
  size_t wr_pos;
};

}

#endif /* __APUEX_RING_BUFFER_CXX_INCLUDED_ */

