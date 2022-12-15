#include <iostream>
#include <cstdio>

void Func_Export();

void SDK1();
void SDK2();

void Func_Local() {
  printf("%s: %s: %d\n", __FILE__, __func__, __LINE__);
  return;
}

class Something{
public:
    int* p1;
    char* p2;
public:
    void doSomething(){
       printf("%s: %s: %d\n", __FILE__, __func__, __LINE__); 
       printf("%p %p\n", p1, p2);
    }
};

void SDK3(Something s);

int main() {
  SDK1();
  SDK2();

  printf("%s: %s: %d\n", __FILE__, __func__, __LINE__);
  printf("  ");
  Func_Export();
  printf("  ");
  Func_Local();

  Something ss;
  SDK3(ss); // Something is a type across library

  return 0;
}
