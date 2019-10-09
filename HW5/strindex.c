#include <stdio.h>

int strindex(char str[], char c) {
    int i = 0;
    while(str[i]) {
        if(str[i] == c) {
            return i;
        }
        i++;
    }
    return -1;
}

int main() {
    char str[50] = "Hello World";
    int str_index = strindex("Hello World", 'W');
    printf("%d", str_index);
    return 0;
}