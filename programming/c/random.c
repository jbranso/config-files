#include <stdio.h>
#include <string.h>
#include <stdlib.h>

void change (char studentID)
{
  printf ("the length of studentId == %d\n", strlen (&studentID));
}

int main ()
{
  /* char array[12] = "12345678901"; */

  /* change (*array); */

  /* int w = 4; */
  /* int x = 13; */

  /* int *y; */
  /* int *z; */

  /* y = &x; */
  /* z = &w; */

  /*  *z = *y % *z; */

  /* z = &x; */
  /* y = z; */
  /* printf ("%d\n", *y); */

  char array[5] = {0};

  printf ("array[0] = %d array[1] = %d array[2] = %d\n", array[0], array[1], array[2]);
  return 0;
}
