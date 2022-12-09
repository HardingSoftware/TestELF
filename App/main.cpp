#include <iostream>

#include "libSDK1.h"
#include "libSDK2.h"

template <typename DType> void Func(DType a);

int main() {
  SDK1();
  SDK2();

  Func<int>(100);

  return 0;
}
