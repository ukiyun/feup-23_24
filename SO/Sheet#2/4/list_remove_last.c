#include <stdio.h>
#include <stdlib.h>
#include "list.h"


void list_remove_last(list* l) {
	/* assumes list l is not empty */
	if (l->size == 1) {
		/* Only one element, free list*/
		free(l->first);
		l->first = NULL;
	}
	else {
		/* Transverse the list to find the second to last node */
		node* secondLast = l->first;
		while (secondLast->next->next != NULL) {
			secondLast = secondLast->next;
		}

		/* Free the last node and update pointers */
		free(secondLast->next);
		secondLast->next = NULL;
	}
	l->size--;
}