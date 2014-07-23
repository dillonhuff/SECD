#include "heap.h"

ERROR_CODE split_heap_obj(HEAP h, HEAP_OBJ to_split, size_t new_size, HEAP_OBJ rest) {
  if (new_size > to_split->size - sizeof(heap_obj)) {
    return OUT_OF_RANGE_SPLIT;
  }
  if (to_split->type != FREE) {
    return SPLITTING_ALLOCATED_HEAP_BLOCK;
  }
  byte* end_of_to_split = (byte*) to_split;
  end_of_to_split += sizeof(heap_obj) + new_size;
  rest = (HEAP_OBJ) &end_of_to_split;
  rest->size = to_split->size - new_size - sizeof(heap_obj);
  rest->mark_status = UNMARKED;
  rest->type = FREE;
  to_split->size = new_size;
  h->available = h->available - HEAP_OBJ_OVERHEAD;
  return SUCCESS;
}

void new_heap(HEAP h, byte *mem, size_t heap_size) {
  h->mem = mem;
  h->available = heap_size - HEAP_OBJ_OVERHEAD;
  h->total_size = heap_size;
  h->first_free = (HEAP_OBJ) h->mem;
  h->first_free->size = h->available;
  h->first_free->mark_status = UNMARKED;
  h->first_free->type = FREE;
  h->first_free->next_free = NULL;
  return;
}

// Uses first fit to find free heap object
ERROR_CODE alloc_mem(HEAP h, size_t amount, byte* ptr, HEAP_OBJ_TYPE type) {
  // Basic sanity check
  if (h->total_size < amount) {
    return HEAP_OVERFLOW;
  }

  HEAP_OBJ prev_obj = NULL;
  HEAP_OBJ cur_obj = h->first_free;
  while (cur_obj != NULL) {
    int leftover = cur_obj->size - amount;
    HEAP_OBJ next_free_obj;
    if (leftover >= 0) {
      if (leftover >= sizeof(heap_obj)) {
	ERROR_CODE split_err = split_heap_obj(h, cur_obj, amount, next_free_obj);
	if (!split_err) {
	  next_free_obj->next_free = cur_obj->next_free; 
	} else {
	  return split_err;
	}
      } else {
	next_free_obj = cur_obj->next_free;
      }
      ptr = (byte*) &(cur_obj->next_free);
      h->available = h->available - cur_obj->size;
      if (prev_obj != NULL) {
	prev_obj->next_free = next_free_obj;
      }
      return SUCCESS;
    }
    prev_obj = cur_obj;
    cur_obj = cur_obj->next_free;
  }
  return HEAP_OVERFLOW;
}
