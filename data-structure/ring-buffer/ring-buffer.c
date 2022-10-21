#ifndef __APUEX_RING_BUFFER_INCLUDED_
#define __APUEX_RING_BUFFER_INCLUDED_

struct apuex_ring_buffer {
  size_t buffer_size;
  size_t element_count;
  size_t read_pos;
  size_t write_pos;
  char* buffer;
};

#endif /* __APUEX_RING_BUFFER_INCLUDED_ */

