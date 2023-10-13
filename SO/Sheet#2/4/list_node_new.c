#include <stdio.h>
#include <stdlib.h>
#include "list.h"

node* node_new(int val, node* p){
    node* q = (node*)malloc(sizeof(node));
    q->val = val;
    q->next = p;
    return q;
}