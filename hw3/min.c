#include <stdio.h>

double min(double num1, double num2)
{
  return num1 < num2 ? num1 : num2;
}

int main()
{
  double num1 = 10;
  double num2 = 20;
  double min_num = min(num1, num2);
  printf("The min of %lf and %lf is %lf\n", num1, num2, min_num);
  return 0;
}