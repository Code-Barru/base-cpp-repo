#include <iostream>
#include "include/main.h"

int main() {

    std::cout << "Hello World!\n";
    std::cout << add(5,6) << std::endl;

    return 0;
}

int add(int a, int b) {
    return a + b;
}