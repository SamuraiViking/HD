#include <stdio.h>
#include <math.h>

void printFactorialUpToNum(num)
{
  int factorial = 1;
  for (int i = 0; i < num; i++)
  {
    if (i == 0 || i == 1)
    {
      printf("%d: %d\n", i, factorial);
    }
    else
    {
      factorial *= i;
      printf("%d: %d\n", i, factorial);
    }
  }
}

int main()
{
  printFactorialUpToNum(10);
  return 0;
}