/**
 * C program to convert Hexadecimal to Decimal number system
 */
#include <stdio.h>
#include <string.h>

int myPow(num, exp) {
  int result = 1;
  for (int i = 0; i < exp; ++i)
  {
    result *= num;
  }
  return result;
}

int main()
{
  char hex[17];
  long long decimal, place;
  int i = 0, val, len;

  decimal = 0;
  place = 1;

  /* Input hexadecimal number from user */
  printf("Enter any hexadecimal number: ");
  gets(hex);

  /* Find the length of total number of hex digit */
  len = strlen(hex);
  len--;

  /*
     * Iterate over each hex digit
     */
  for (i = 0; hex[i] != '\0'; i++)
  {

    /* Find the decimal representation of hex[i] */
    if (hex[i] >= '0' && hex[i] <= '9')
    {
      val = hex[i] - 48;
    }
    else if (hex[i] >= 'a' && hex[i] <= 'f')
    {
      val = hex[i] - 97 + 10;
    }
    else if (hex[i] >= 'A' && hex[i] <= 'F')
    {
      val = hex[i] - 65 + 10;
    }

    decimal += val * myPow(16, len);
    len--;
  }
  printf("The value of %s hexadecimal is %lld\n", hex, decimal);

  return 0;
}