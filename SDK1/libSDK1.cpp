#include <iostream>

#include "libSDK1.h"

template <typename DType>
__attribute__((noinline)) 
__attribute__((visibility("default"))) 
DType TemplateFunc(DType a) {
  printf("%s:%d:%s\n", __FILE__, __LINE__, __func__);
  return a;
}

__attribute__((visibility("default"))) 
__attribute__((noinline)) 
void Func()
{
  printf("%s:%d:%s\n", __FILE__, __LINE__, __func__);
}

void SDK1() {
  printf("%s:%d:%s\n", __FILE__, __LINE__, __func__);
  printf("  ");
  TemplateFunc<int>(1);
  printf("  ");
  Func();
}
