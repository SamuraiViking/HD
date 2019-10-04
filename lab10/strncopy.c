#include <stdio.h>

void strncopy(char a[], char b[], int index) {
    printf("%c", b[0]);
    for(int i = 0; i < index; i++) {
        a[i] = b[i];
    }

    printf("\nCalling strncopy(A, \"%s\", %d);\n", b, index);
    printf("The array A now contains string \"%s\"\n", a);
}

int main() {
    char A[100];
    strncopy(A, "The end", 5);
    return 0;
}