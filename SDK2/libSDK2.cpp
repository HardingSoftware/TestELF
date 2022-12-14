#include <iostream>

template <typename DType>
__attribute__((noinline)) 
__attribute__((visibility("default"))) 
DType TemplateFunc(DType a) {
  printf("%s:%d:%s\n", __FILE__, __LINE__, __func__);
  return a;
}

__attribute__((noinline)) 
__attribute__((visibility("default"))) 
void Func()
{
  printf("%s:%d:%s\n", __FILE__, __LINE__, __func__);
}

__attribute__((visibility("default"))) void SDK2() {
  printf("%s:%d:%s\n", __FILE__, __LINE__, __func__);
  printf("  ");
  TemplateFunc<int>(1);
  printf("  ");
  Func();
}
