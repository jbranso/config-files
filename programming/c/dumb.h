// printf cannot be used without stdio.h
#include <stdio.h>

void hello_world () {
  printf ("Hello World\n");
}

void swap (int *a, int *b) {
  printf ("a did == %d and b did == %d, but \n", *a, *b);
  int temp_a = *a;
  *a = *b;
  *b = temp_a;
  printf ("now a == %d and b == %d \n", *a, *b);
}
