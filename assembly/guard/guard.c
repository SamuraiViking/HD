#include <stdio.h>

int main() {
    int x = 5;

    if(x < 5) {
        printf("%d is less than 5\n", x);
    } else if (x == 5) {
        printf("%d is equal to 5\n", x);
    } else {
        printf("%d is greater than 5\n", x);
    }

    return 0;
}