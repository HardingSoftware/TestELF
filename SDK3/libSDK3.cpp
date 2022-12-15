#include <iostream>
#include <cstdio>

class Something{
public:
    int* p1;
public:
    void doSomething(){
       printf("%s: %s: %d\n", __FILE__, __func__, __LINE__); 
       printf("%p\n", p1);
    }
};

__attribute__((visibility("default"))) void SDK3(Something s) {
    s.doSomething();
}
