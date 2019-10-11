#include<stdio.h>


#include<stdio.h>

int getbit(int num, int index) {
    int i;
    int k = num >> index;
    int binary = k & 1 ? 1 : 0;
    return binary;
}

void print_bits(char c) {
    int binary;
    int i;
    for(i = 7; i >= 0; i--) { 
        binary = getbit(c, i);
        printf("%d", binary);
    }
}

int main() {
    print_bits('a');
    return 0;
}