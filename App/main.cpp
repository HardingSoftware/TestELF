#include <iostream>
#include <cstdio>

template <typename DType> DType TemplateFunc(DType a);
void Func();

void SDK1();
void SDK2();

void cook() {
  printf("%s:%d:%s\n", __FILE__, __LINE__, __func__);
  return;
}

int main() {
  cook();

  SDK1();
  SDK2();

  printf("%s:%d:%s\n", __FILE__, __LINE__, __func__);
  printf("  ");
  TemplateFunc<int>(1);
  printf("  ");
  Func();

  return 0;
}
