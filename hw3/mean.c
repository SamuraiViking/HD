#include<stdio.h>

double mean(double num1, double num2) {
  return (num1 + num2) / 2;
}

int main() {
  double num1 = 10;
  double num2 = 20;
  double mean_num = mean(num1, num2);
  printf("The mean of %lf and %lf is %lf\n", num1, num2, mean_num);
  return 0;
}