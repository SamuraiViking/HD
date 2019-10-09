#include <stdio.h>

void strappend(char str1[], char str2[]) {
    int i = 0;
    while(str1[i]) {
        i++;
    }
    int j = 0;
    while(str2[j]) {
        str1[i] = str2[j];
        j++;
        i++;
    }
}


int main() {
    char A[100] = "From start ";
    strappend(A, "to finish");
    printf("%s\n", A);
    return 0;
}