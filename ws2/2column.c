#include<stdio.h>
#include<math.h>

double sqrt2(double num) {
  if(num < 0) {
    printf("%lf is negative\n", num);
    return -1;
  }
  printf("the sqrt of %lf is %lf\n", num, sqrt(num));
  return sqrt(num);
}

int min_pair(int num1, int num2) {
  return num1 < num2 ? num1 : num2;
}

int print_squares(int start, int end) {
  int num_of_lines = 0;
  for(int i = start; i < end; i++) {
    num_of_lines++;
    printf("%d\t%d\n", i, i * i);
  }
  return num_of_lines;
}

int main() {
  // printf("The smaller number is %d\n",min_pair(30, 20));
  print_squares(-1, 3);
  return 0;
}