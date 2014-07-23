#ifndef HEAP_H
#define HEAP_H

#include "utils.h"

typedef char HEAP_OBJ_TYPE;

#define FREE 0

typedef char MARKED_STATUS;

#define UNMARKED 0
#define MARKED 1

struct heap_obj {
  size_t num_bytes;
  MARKED_STATUS mark_status;
  HEAP_OBJ_TYPE type;
  struct heap_obj* next_free;
};

typedef struct heap_obj heap_obj;
typedef struct heap_obj* HEAP_OBJ;

#define HEAP_OBJ_OVERHEAD (sizeof(heap_obj) - sizeof(struct heap_obj*))

struct heap {
  char *mem;
  size_t available_bytes;
  size_t total_bytes;
  HEAP_OBJ first_free;
};

typedef struct heap heap;
typedef struct heap* HEAP;

void new_heap(HEAP h, char *mem, size_t heap_size);
ERROR_CODE alloc_mem(HEAP h, size_t amount, void *ptr);

#endif
