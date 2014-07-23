#include "heap.h"
#include "linked_list.h"

ERROR_CODE alloc_ll_node(HEAP h, LIST l) {
  return alloc_mem(h, sizeof(list), (byte*) l, LL_NODE);
}

ERROR_CODE push_list(HEAP h, LIST l, void* data) {
  LIST new_node;
  ERROR_CODE alloc_err = alloc_ll_node(h, new_node);
  if (!alloc_err) {
    new_node->data = data;
    l->next = new_node;
    new_node->next = NULL;
    l = l->next;
    return SUCCESS;
  }
  return alloc_err;
}

ERROR_CODE pop_list(LIST l, void* data) {
  if (l == NULL) {
    return LIST_EMPTY;
  }
  data = l->data;
  l = l->next;
  return SUCCESS;
}
