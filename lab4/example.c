#include <stdio.h>
#include <math.h>
#include <stdbool.h>
#include <string.h>

bool floatIsInt(float num) {
  return (int)num == num;
}

float printNumberFacts(float num) {
  if(num > 0) {
    if(floatIsInt(num)) {
      printf("%f is an integer\n", num);
      if(floatIsInt(sqrt(num))) {
        printf("%f's square, %f is an integer\n", num, sqrt(num));
      }
    }
    printf("%f is positive\n", num);
  } else if(num == 0) {
    printf("%f is zero\n", num);
  } else {
    printf("%f is negative\n", num);
  }
  return num;
}



int main() {

  float input;
  puts("Give me a number:");
  scanf("%f", &input);
  printf("\n");
  printNumberFacts(input);
  return 0;
}

