#include <stdio.h>
#include <math.h>

void printFactorialUpToNum(num)
{
  int factorial = 1;
  printf("k\tk!\n");
  printf("-\t-----\n");
  for (int i = 0; i <= num; i++)
  {
    if (i == 0 || i == 1)
    {
      printf("%d\t%d\n", i, factorial);
    }
    else
    {
      factorial *= i;
      printf("%d\t%d\n", i, factorial);
    }
  }
}

int main()
{
  printFactorialUpToNum(5);
  return 0;
}