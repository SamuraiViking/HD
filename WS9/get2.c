#include <stdio.h>

int getTwoNums(int * x, int * y) {
    return scanf("%d %d", x, y);
}

int main() {


    int x, y;
    getTwoNums(&x, &y);
    printf("%d %d", x, y);

    return 0;
}