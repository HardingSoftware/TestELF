#include <iostream>

#include "libSDK2.h"

int GetSum(const std::vector<int>& v) {
  size_t N = v.size();

  int sum = 0;
  for (size_t n0 = 0; n0 < N; ++n0) {
    sum +=v[n0];
  }
  return sum;
}
