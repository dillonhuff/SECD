#include "heap.h"
#include "linked_list.h"

ERROR_CODE push_list(HEAP h, LIST l, void *data) {
  LIST new_node;
  ERROR_CODE alloc_err = alloc_mem(h, sizeof(list), new_node);
  if (!alloc_err) {
    new_node->data = data;
    l->next = new_node;
    new_node->next = NULL;
    l = l->next;
    return SUCCESS;
  }
  return alloc_err;
}

ERROR_CODE pop_list(LIST l, void *data) {
  return SUCCESS;
}
