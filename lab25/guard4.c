#include<stdio.h>

int guard(int x) {
    if('a' <= x && x <= 'z') {
        printf("%c is <= a and <= z\n", x);
        return 1;
    }
    printf("%c is not <= a or <= z\n", x);
    return 0;
}

int main() {

    int x;
    printf("Enter one char x: ");
    scanf("%c", &x);

    guard(x);


    return 0;
}