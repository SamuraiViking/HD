#include <stdio.h>

int strLen(char * str) {
    char * strp = str;
    int i = 0;
    while(*strp != '\0') {
        strp++;
        i++;
    }
    return i;
}

int main() {
    int x;
    x = strLen("The end");
    printf("%d\n", x);
    return 0;
}