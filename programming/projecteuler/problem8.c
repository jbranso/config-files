#include <stdio.h>
#include <string.h>
// I need this function to compute the result
int product (int x1, int x2, int x3, int x4, int x5, int x6, int x7, int x8, int x9, int x10, int x11, int x12, int x13) {
  return x1 * x2 * x3 * x4 * x5 * x6 * x7 * x8 * x9 * x10 * x11 * x12 * x13;
}

//since the largest product will consist of the same numbers that make the largest sum,  I'll just find the largest sum first
//this might not be correct 9 + 9 + 9 + ... + 0 may be the largest sum BUT not the largest product
int sumf (int x1, int x2, int x3, int x4, int x5, int x6, int x7, int x8, int x9, int x10, int x11, int x12, int x13) {
  return x1 + x2 + x3 + x4 + x5 + x6 + x7 + x8 + x9 + x10 + x11 + x12 + x13;
}

//this will return the index that holds the largest sum
int largestSumAtIndex (char string []) {
  int stringLength = strlen (string);
  int maxSum = 0;
  int sum = 0;
  int i = 0;
  for (i = 0; i < stringLength - 12; i++) {
    sum = sumf ((int)string [i], (int)string[i+1], (int)string[i+2], (int)string [i+3], (int)string [i+4], (int)string [i+5], (int)string [i+6], (int)string [i+7], (int)string [i+8], (int)string [i+9], (int)string [i+10], (int)string [i+11], string [i+12]);
    maxSum = sum > maxSum ? sum : maxSum;
  }
  return i;
}

//this will return the index that holds the largest product
int largestProductAtIndex (char string []) {
  int stringLength = strlen (string);
  int maxProduct = 0;
  int productf = 0;
  int i = 0;
  for (i = 0; i < stringLength - 12; i++) {
    productf = product ((int)string [i], (int)string[i+1], (int)string[i+2], (int)string [i+3], (int)string [i+4], (int)string [i+5], (int)string [i+6], (int)string [i+7], (int)string [i+8], (int)string [i+9], (int)string [i+10], (int)string [i+11], string [i+12]);
    maxProduct = productf > maxProduct ? productf : maxProduct;
  }
  return i;
}

int main () {
  char string [] = "7316717653133062491922511967442657474235534919493496983520312774506326239578318016984801869478851843858615607891129494954595017379583319528532088055111254069874715852386305071569329096329522744304355766896648950445244523161731856403098711121722383113622298934233803081353362766142828064444866452387493035890729629049156044077239071381051585930796086670172427121883998797908792274921901699720888093776657273330010533678812202354218097512545405947522435258490771167055601360483958644670632441572215539753697817977846174064955149290862569321978468622482839722413756570560574902614079729686524145351004748216637048440319989000889524345065854122758866688116427171479924442928230863465674813919123162824586178664583591245665294765456828489128831426076900422421902267105562632111110937054421750694165896040807198403850962455444362981230987879927244284909188845801561660979191338754992005240636899125607176060588611646710940507754100225698315520005593572972571636269561882670428252483600823257530420752963450";
  int i = largestProductAtIndex (string);
  int maxProduct =  product (string[i], string[i,1], string [i, 2], string [i, 3], string [i, 4], string [i, 5], string [i, 6], string [i, 7], string [i, 8], string [i, 9], string [i, 10], string [i, 11], string [i, 12]);
  printf ("the greateng product is %d \n", maxProduct);
}
