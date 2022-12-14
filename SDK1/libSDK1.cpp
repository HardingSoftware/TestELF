#include <iostream>
#include <cstdio>

__attribute__((visibility("default"))) 
__attribute__((noinline)) 
void Func_Export()
{
  printf("%s: %s: %d\n", __FILE__, __func__, __LINE__);
}

void Func_Local()
{
  printf("%s: %s: %d\n", __FILE__, __func__, __LINE__);
}

__attribute__((visibility("default"))) void SDK1() {
  printf("%s: %s: %d\n", __FILE__, __func__, __LINE__);
  printf("  ");
  Func_Export();
  printf("  ");
  Func_Local();
}

