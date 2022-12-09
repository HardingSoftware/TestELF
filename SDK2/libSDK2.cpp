#include <iostream>

#include "libSDK2.h"

template <typename DType>
__attribute__((noinline)) __attribute__((weak))
__attribute__((visibility("default"))) void
Func(DType a) {
  printf("%s:%d:%s\n", __FILE__, __LINE__, __func__);
  printf("  p = %d\n", a);
}

void SDK2() {
  printf("%s:%d:%s\n", __FILE__, __LINE__, __func__);
  Func<int>(2);
}
