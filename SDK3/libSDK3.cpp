#include <cstdio>
#include <iostream>
#include <vector>

class Something {
public:
  int *p1;

public:
  void doSomething() {
    printf("%s: %s: %d\n", __FILE__, __func__, __LINE__);
    printf("%p\n", p1);
  }
};

__attribute__((visibility("default"))) void SDK3(Something s) {
  s.doSomething();
}

__attribute__((visibility("default"))) int sum(std::vector<int> v) {
  int sum = 0;
  for (int i0 = 0; i0 < v.size(); ++i0) {
    sum += v[i0];
  }
  return sum;
}

class BaseV {
public:
  int base;
  virtual void funcV();
  void func();
};

void BaseV::funcV() {}
void BaseV::func() {}

class __attribute__((__visibility__("default"))) ClassV1 : public BaseV {
public:
  int i;
  void funcV() override;
};

void ClassV1::funcV() {}

class __attribute__((__type_visibility__("default"))) ClassV2 : public BaseV {
public:
  int i;
  void funcV() override;
};

void ClassV2::funcV() {}

class Base {
public:
  int base;
  void func();
};

void Base::func() {}

class __attribute__((__visibility__("default"))) Class1 : public Base {
public:
  int i;
  void func();
};

void Class1::func() {}

class __attribute__((__type_visibility__("default"))) Class2 : public Base {
public:
  int i;
  void func();
};

void Class2::func() {}
