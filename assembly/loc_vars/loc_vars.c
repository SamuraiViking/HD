#include <stdio.h>

int sum(int a, int b, int c, int d, int e) {
    return a + b + c + d + e;
}

int main() {

    int a = 1;
    int b = 2;
    int c = 3;
    int d = 4;
    int e = 5;

    int the_sum = sum(a, b, c, d, e);

    printf("sum(%d, %d, %d, %d, %d) == %d\n", a, b, c, d, e, the_sum);

    return 0;
}