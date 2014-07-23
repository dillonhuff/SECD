#ifndef HEAP_H
#define HEAP_H

#include "utils.h"

typedef char HEAP_OBJ_TYPE;

#define FREE 0
#define LL_NODE 1

typedef char MARKED_STATUS;

#define UNMARKED 0
#define MARKED 1

struct heap_obj {
  size_t size;
  MARKED_STATUS mark_status;
  HEAP_OBJ_TYPE type;
  struct heap_obj* next_free;
};

typedef struct heap_obj heap_obj;
typedef struct heap_obj* HEAP_OBJ;

#define HEAP_OBJ_OVERHEAD (sizeof(heap_obj) - sizeof(struct heap_obj*))

struct heap {
  byte *mem;
  size_t available;
  size_t total_size;
  HEAP_OBJ first_free;
};

typedef struct heap heap;
typedef struct heap* HEAP;

void new_heap(HEAP h, byte *mem, size_t heap_size);
ERROR_CODE alloc_mem(HEAP h, size_t amount, byte *ptr, HEAP_OBJ_TYPE type);

#endif
