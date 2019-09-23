#include <stdio.h>
#include <math.h>

void printSqRootsUpToNum(num)
{
  for (int i = 0; i <= num; i++)
  {
    float sqNum = sqrt(i);
    printf("%d: %f\n", i, sqNum);
  }
}

int main()
{
  printSqRootsUpToNum(5);
  return 0;
}