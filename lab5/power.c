#include <stdio.h>

int power(int num) {
  return num * num;
}

int main() {
  int num = 10;
  printf("The power of %i is %i\n", num, power(num));
  return 0;
}