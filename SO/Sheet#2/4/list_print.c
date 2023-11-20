#include <stdio.h>
#include <stdlib.h>
#include "list.h"


void list_print(list* l) {
	printf("List Size: %d\n", list_size(l));
	/* assumes list l is not empty */
	node* p = l->first;
	int i = 1;
	while (p->next != NULL) {
		printf("Element %d: %d", i,p->val);
		printf("\n");
		p = p->next;
		i++;
	}
	printf("Element %d: %d", i, p->val);
	free(p);
}