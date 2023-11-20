#include <stdio.h>
#include <stdlib.h>
#include "list.h"


int main(int argc, char** argv) {
    list* l1 = list_new();
    list* l2 = list_new();
    list* l3 = list_new();
    list_add_first(1, l1);
    list_add_first(2, l2);
    list_add_first(3, l3);
    list_add_last(3, l1);
    list_add_last(2, l2);
    list_add_last(1, l3);
    list_add_last(4, l1);
    list_add_last(5, l2);
    list_add_last(6, l3);
    list_add_first(11, l1);
    list_add_first(22, l2);
    list_add_first(33, l3);

    int l1Last = list_get_last(l1);
    int l2Last = list_get_last(l2);
    int l3Last = list_get_last(l3);

    int l1First = list_get_first(l1);
    int l2First = list_get_first(l2);
    int l3First = list_get_first(l3);

    list_remove_last(l2);
    list_remove_last(l3);

    list_remove_first(l1);
    list_remove_first(l3);

    int list1Size = list_size(l1);
    int list2Size = list_size(l2);
    int list3Size = list_size(l3);
    
    printf("List 1 First Element: %d\n", l1First);
    printf("List 1 Last Element: %d\n", l1Last);
    printf("List 2 First Element: %d\n", l2First);
    printf("List 2 Last Element: %d\n", l2Last);
    printf("List 3 First Element: %d\n", l3First);
    printf("List 3 Last Element: %d\n", l3Last);

    printf("List 1 Size: %d\n", list1Size);
    printf("List 2 Size: %d\n", list2Size);
    printf("List 3 Size: %d\n", list3Size);


    list_print(l1);
    list_print(l2);
    list_print(l3);

    return 0;
}