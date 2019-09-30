#include <stdio.h>

int read_array2(char arr[], int size) {
  scanf("%[^\n]s", arr);
  int i;
  char new_arr[size - 1];
  for(i = 0; i < size - 1; i++) {
    new_arr[i] = arr[i];
  }
  printf("%s\n", new_arr);
  return 0;
}

int main() {
  char arr[250];
  read_array2(arr, 3);
  return 0;
}