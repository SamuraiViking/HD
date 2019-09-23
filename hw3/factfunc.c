#include<stdio.h>

int fact(int num) {
  if(num == 0) {
    return 0;
  }

  int num_fact = 1;
  while(num > 0) {
    num_fact *= num;
    num--;
  }
  return num_fact;
}

void factFunc(num) {
  int i = 0;
  for(i = 0; i <= num; i++) {
    printf("The factorial of %d is %d\n", i, fact(i));
  }
}

int main() {

  factFunc(5);
  return 0;
}