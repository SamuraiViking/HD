#include<stdio.h>

int prod_array(int a[], int size)
{
  int i, prod = 1;
  for (i = 0; i < size; i++)
    prod = prod * a[i];
  return prod;
}

int main() {
  int arr[] = {1,2,3};
  int arr_prod = prod_array(arr, 3);
  printf("The product of array elements is %d\n", arr_prod);
  return 0;
}
