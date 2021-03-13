
#include <stdio.h>
#include <iostream>
#include <fstream>
#include "hello.h"
using namespace std;

int main(int argc, char const *argv[])
{
  writeInFile();
  return 0;
}


extern "C" /* <= C++ only */ __attribute__((visibility("default"))) __attribute__((used))
int native_sum(int x, int y)
{
    return x + y;
}

extern "C" /* <= C++ only */ __attribute__((visibility("default"))) __attribute__((used))
void writeInFile(){
  ofstream myfile;
  myfile.open("sample.txt");
  myfile << myfile.r "Hola mundo \n";
  myfile.close();
}