#include<stdio.h>

int main() {
  int y;
  printf("Enter a decimal: ");
  scanf("%d",&y);
  printf("The value of x is %d in decimal, %x in hexadecimal\n",y, y);
  return 0;
}