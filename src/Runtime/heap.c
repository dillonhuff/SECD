#include "heap.h"

void new_heap(HEAP h, char *mem, size_t heap_size) {
  h->mem = mem;
  h->available_bytes = heap_size - HEAP_OBJ_OVERHEAD;
  h->total_bytes = heap_size;
  h->first_free = (HEAP_OBJ) h->mem;
  h->first_free->num_bytes = h->available_bytes;
  h->first_free->mark_status = UNMARKED;
  h->first_free->type = FREE;
  h->first_free->next_free = NULL;
  return;
}

ERROR_CODE alloc_mem(HEAP h, size_t amount, void* ptr) {
  return HEAP_OVERFLOW;
}
