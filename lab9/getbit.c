#include<stdio.h>

int getbit(int num, int index) {
    int i;
    int k = num >> index;
    int binary = k & 1 ? 1 : 0;
    return binary;
}

int main() {
    int i;
    int input;
    printf("Enter Hexadecimal: ");
    scanf("%x", &input);
    for(i = 0; i < 8; i++) {
        int binary = getbit(input, i);
        printf("[%d] %d\n", i , binary);
    }
    return 0;
}