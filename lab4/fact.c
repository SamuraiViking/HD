#include <stdio.h>
#include <math.h>

void printFactorial(num)
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
  printFactorial(10);
  return 0;
}