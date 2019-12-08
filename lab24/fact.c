#include <stdio.h>

int fact(int n) {
  if (n <= 1)
    return 1;
  else
    return n*fact(n-1);
}

int main() {
    int x = 5;
    int factX = fact(x);
    printf("The fact of %d is %d\n", x, factX);
    return 0;
}
