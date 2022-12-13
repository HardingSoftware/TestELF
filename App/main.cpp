#include <iostream>

#include "libSDK1.h"
#include "libSDK2.h"

template <typename DType> DType TemplateFunc(DType a);
void Func();

int main() {
  SDK1();
  SDK2();

  printf("%s:%d:%s\n", __FILE__, __LINE__, __func__);
  printf("  ");
  TemplateFunc<int>(1);
  printf("  ");
  Func();

  return 0;
}
