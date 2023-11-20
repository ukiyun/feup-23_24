#include <stdio.h>
#include <stdlib.h>
#include "list.h"


int list_size(list* l) {
	/* assumes list l is not empty */
	return l->size;
}