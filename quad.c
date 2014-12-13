#include <stdio.h>
#include <stdlib.h>
#include "symbol.h"
#include "quad.h"

struct quad* quad_gen(int* label, char op,
                      struct symbol* arg1,
                      struct symbol* arg2,
                      struct symbol* res) {
  struct quad* new = (struct quad*)malloc(sizeof(struct quad));
  new->label = *label;
  (*label)++;
  new->op = op;
  new->arg1  = arg1;
  new->arg2  = arg2;
  new->res   = res;
  new->next  = NULL;
  return new;
}

void quad_add(struct quad** list, struct quad* new) {
  struct quad* scan;
  
  if (*list == NULL) {
    *list = new;
  } else {
    scan = *list;
    while (scan->next != NULL)
      scan = scan->next;
    scan->next = new;
  }
}

void quad_print(struct quad* quad){
  while (quad != NULL) {
    printf("%2d: %c %7s %7s %7s\n", quad->label, quad->op,
           (quad->arg1 != NULL) ? quad->arg1->identifier : "NULL",
           (quad->arg2 != NULL) ? quad->arg2->identifier : "NULL",
           (quad->res  != NULL) ? quad->res->identifier  : "NULL");
    quad = quad->next;
  }
}

struct quad_list* quad_list_new(struct quad* node) {
  struct quad_list* new = (struct quad_list*)malloc(sizeof(struct quad_list));
  new->node = node;
  new->next = NULL;
  return new;
}

void quad_list_concat(struct quad_list* l1, struct quad_list* l2) {
  while (l1->next != NULL)
    l1 = l1->next;
  l1->next = l2;
}

void quad_list_complete(struct quad_list* list, struct symbol* label) {
  while (list != NULL) {
    list->node->res = label;
    list = list->next;
  }
}

void quad_list_print(struct quad_list* list) {
  int i = 0;
  while (list != NULL) {
    printf("Node %2d:\n", i);
    quad_print(list->node);
    printf("\n");
    list = list->next;
  }
}
