#include <iostream>

#include "libSDK1.h"

std::vector<int> CreateVec(int n) {
  std::vector<int> v(n);
  for (int n0 = 0; n0 < n; ++n0) {
    v[n0] = n0;
  }
  return v;
}

void add1(std::vector<int> &v) {
  for (int s0 = 0; s0 < v.size(); ++s0) {
    v[s0] += 1;
  }
}

void cook(std::vector<TestType> &vt) {
  for (int s0 = 0; s0 < vt.size(); ++s0) {
    vt[s0].a = 2;
    vt[s0].b = 3;
    vt[s0].c = 4;
    vt[s0].d = 5;
  }
}