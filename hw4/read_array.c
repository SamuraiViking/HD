#include <stdio.h>

int read_array(int arr[], int size) {

  int val;
  int num_of_inputs = 0;
  while (scanf("%d", &val) != EOF) {
    if(num_of_inputs >= size - 1) {
      arr[num_of_inputs] = val;
      break;
    }
    arr[num_of_inputs] = val;
    num_of_inputs++;
  }
  int i;
  printf("You inputed the numbers ... \n");
  for(i = size - 1; i >= 0; i--) {
    printf("%d\n", arr[i]);
  }
  return num_of_inputs;
}

int main() {
  int arr[10];
  read_array(arr, 10);
}