#include <stdio.h>

int strindexp(char * str, char c) {
    int i = 0;
    while(*str) {
        if(*str == c) {
            return i;
        }
        str++;
        i++;
    }
    return -1;
}

int main() {
    int i = strindexp("Hello World", 'Z');
    printf("%d", i);
}