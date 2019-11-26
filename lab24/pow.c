#include<stdio.h>

int myPow(int x, int n) {
    int i = 0;
    int result = 1;
    while(i < n) {
        result *= x;
        i++;
    }
    return result;
}

int main() {

    int x;
    int y;
    printf("Give me two numbers: ");
    scanf("%d %d", &x, &y);

    int result = myPow(x, y);

    printf("myPow(%d, %d) == %d", x, y, result);

    return 0;
}