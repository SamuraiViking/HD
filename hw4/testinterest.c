#include<stdio.h>

double moIntrest(double amount, float intrest_rate) {
  return amount * intrest_rate / 1200;
}
int main() {
  printf("%f", moIntrest(10000, 6));
}