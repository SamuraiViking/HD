#include<stdio.h>

int fact(int num) {
	if(num >= 1)
		return num * fact(num - 1);
	else
		return 1;
}


int main() {
	int input;
	printf("Enter a non-negative integer: ");
	scanf("%d", &input);
	printf("The factorial of %d is %d", input,fact(input));
	return 0;
}
