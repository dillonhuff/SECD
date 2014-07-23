#ifndef HEAP_H
#define HEAP_H

#include "utils.h"

struct heap {
  char *mem;
  unsigned int available_bytes;
  unsigned int total_bytes;
};

typedef struct heap heap;
typedef struct heap* HEAP;

ERROR_CODE alloc_mem(HEAP h, size_t amount, void *ptr);

#endif
