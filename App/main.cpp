#include <iostream>

#include "libSDK1.h"
#include "libSDK2.h"

int main() {

  // std::vector<int> v0(10);
  // v0[11] = 2;

  int n = 100;

  std::vector<int> v = CreateVec(n); // SDK1
  add1(v);                           // SDK1

  int sum = GetSum(v); // SDK2

  printf("SUM %d\n", sum);

  std::vector<TestType> vt(100);

  cook(vt);

  return 0;
}
