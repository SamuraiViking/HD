#include <stdio.h>

int get_trans(char * str) {

    if(str[1] != ' ') {
        printf("There was not a \" \" in str[1]");
        return 0;
    }

    if(str[3] != '\n') {
        printf("There was not a \\n in str[3]");
        return 0;
    }
    printf("%s", str);
    return 0;
}

int main() {

    char * str = "H E\n";
    get_trans(str);

    return 0;
}