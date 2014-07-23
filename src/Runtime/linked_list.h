#ifndef LINKED_LIST_H
#define LINKED_LIST_H

#include "utils.h"

struct list {
  struct list* next;
  void *data;
};

typedef struct list list;
typedef struct list* LIST;

ERROR_CODE push_list(HEAP h, LIST l, void *data);
ERROR_CODE pop_list(LIST l, void *data);

#endif
