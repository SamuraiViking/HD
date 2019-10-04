#include<stdio.h>

int myStrlen(char str[]) {
    int len = 0;
    while(str[len] != '\0') len++;
    return len;
}

int main() {
    char str[100] = "The end";
    printf("The return value from strlen( \"%s\" ) is %d\n", str, myStrlen(str));
    return 0;
}