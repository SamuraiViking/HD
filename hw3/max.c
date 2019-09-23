#include<stdio.h>

double max(double num1, double num2) {
  return num1 > num2 ? num1 : num2;
}

int main() {
  double num1 = 10;
  double num2 = 20;
  double max_num = max(num1, num2);
  printf("The max of %lf and %lf is %lf\n", num1, num2,max_num);
  return 0;
}