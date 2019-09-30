#include <stdio.h>

int sum_array(int arr[], int size)
{
  int val;
  int sum = 0;
  int i;
  for (i = 0; i < size; i++)
  {
    sum += arr[i];
  }
  return sum;
}

double mean_array(int arr[], int size) {
  double sum = sum_array(arr, size);
  return sum / size;
}

int main() {
  int size = 4;
  int arr[] = {16,40,20,82};
  double mean = mean_array(arr, size);
  printf("The mean of the elements is %f\n", mean);
  return 0;
}