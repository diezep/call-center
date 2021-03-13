#include <stdio.h>

using namespace std;


extern "C" /* <= C++ only */ __attribute__((visibility("default"))) __attribute__((used))
int native_sum(int x, int y);

extern "C" /* <= C++ only */ __attribute__((visibility("default"))) __attribute__((used))
void writeInFile();