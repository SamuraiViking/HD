#include <stdio.h>

double mean(double num1, double num2)
{
  return (num1 + num2) / 2;
}

int sum_input()
{
  int val;     /* holds next integer value from standard input */
  int sum = 0; /* sum of input integers so far */
  while (scanf("%d", &val) != EOF)
    sum = sum + val;
  return sum;
}

double mean_input()
{
  int val;
  int sum = 0;
  int amount_of_nums = 0;
  while(scanf("%d", &val) != EOF)
  {
    amount_of_nums += 1;
    sum = sum + val;
  }
  return sum / amount_of_nums;
}

int main()
{
  printf("Enter some values, press CTRL/D when your done\n");
  printf("The return value from calling mean_input() is %f\n", mean_input());
  return 0;
}