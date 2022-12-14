#include <iostream>
#include <cstdio>

void Func_Export();

void SDK1();
void SDK2();

void Func_Local() {
  printf("%s: %s: %d\n", __FILE__, __func__, __LINE__);
  return;
}

int main() {
  SDK1();
  SDK2();

  printf("%s: %s: %d\n", __FILE__, __func__, __LINE__);
  printf("  ");
  Func_Export();
  printf("  ");
  Func_Local();

  return 0;
}
