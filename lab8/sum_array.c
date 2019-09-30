#include <stdio.h>

int sum_array(int arr[], int size)
{
  int val;
  int sum = 0;
  int i;
  for(i = 0; i < size; i++) {
    sum += arr[i];
  }
  return sum;
}

int main() {
  int arr[4] = {16, 40, 20, 82};
  int val = sum_array(arr, 4);
  printf("The sum of the array integers is %d\n", val);
  return 0;
}