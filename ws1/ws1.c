#include <stdio.h>
#include <math.h>
#include <stdbool.h>

void printNumIsBigOrSmall(int num) {
  num > 20 ? printf("The num %i is big\n", num) : printf("The num %i is small\n", num);
};

void printSqRoot(int num) {
  printf("The square root of %d is %f\n", num ,sqrt(num));
};

void printNumFacts(int input) {
  printNumIsBigOrSmall(input);
  printSqRoot(input);
};

bool validInput(int input) {
  if(input < 0) {
    printf("input must be postiive\n");
    return false;
  }
  return true;
};

int promptUserForNum() {
  int input;
  puts("Input a number:");
  scanf("%i", &input);
  return input;
};

int subtractNums(int num1, int num2) {
  if((num1 - num2) > 0) {
    printf("The value if i-f is %d\n", num1 - num2);
  }
  return 0;
}

int main()
{
  int input = promptUserForNum();
  while(!validInput(input)) {
    input = promptUserForNum();
  }
  printNumFacts(input);
  int num1 = promptUserForNum();
  int num2 = promptUserForNum();
  subtractNums(num1, num2);

  return 0;
}