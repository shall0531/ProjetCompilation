struct quad {
  int label;
  char op;
  struct symbol* arg1;
  struct symbol* arg2;
  struct symbol* res;
  struct quad*   next;
};

struct quad_list {
  struct quad* node;
  struct quad_list* next;
};

struct quad* quad_gen(int*, char, struct symbol*, struct symbol*, struct symbol*);
void         quad_add(struct quad**, struct quad*);
void         quad_print(struct quad*);

struct quad_list* quad_list_new(struct quad*);
void quad_list_concat(struct quad_list*, struct quad_list*);
void quad_list_complete(struct quad_list*, struct symbol*);
void quad_list_print(struct quad_list*);

