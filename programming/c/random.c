#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <math.h>
#include "math.h"
#include "dumb.h"
#include "void.h"


int main ()
{
  int   a = 8;
  int b = 3;

  char string = 'hello';

  int sumAB = sum (a,b);

  int diffAB = diff (a, b);

  double meanAB = mean (a, b);

  printf ("The sum is: %d, the difference is: %d, the mean is: %.2f\n", sumAB, diffAB, meanAB);

  printf("C is %s\n", string);

  hello_world ();

  swap (&a, &b);

  print_nonsense ();

  return 0;
}
