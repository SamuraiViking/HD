#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>

int main()
{
  pid_t pid = getpid();
  sleep(1);
  printf("pid=%d %s", pid, "Hello world\n");
  return 0;
}