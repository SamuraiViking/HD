#include <stdio.h>

void strncopy(char a[], char b[], int index) {
    printf("%c", b[0]);
    for(int i = 0; i < index; i++) {
        a[i] = b[i];
    }

    printf("\nCalling strncopy(A, \"%s\", %d);\n", b, index);
    printf("The array A now contains string \"%s\"\n", a);
}

int strncopyp(char * strp1, char * strp2, int index) {
  while (*strp1) {
    *strp1++ = *strp2++;
  } 
  return index;
}

int main() {
    char A[100];
    strncopyp(A, "The end", 5);
    printf("%s\n", A);
    return 0;
}