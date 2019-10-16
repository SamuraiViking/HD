#include <stdio.h>

void strappendp(char * str1, char * str2) {
    while(*str1) str1++;
    while(*str2) {
        *str1 = *str2;
        str2++;
        str1++;
    }
}

int main() {
    char A[50] = "hello";
    strappendp(A, " World");
    printf("%s", A);
    return 0;
}