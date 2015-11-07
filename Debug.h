#ifndef DEBUG_H
#define DEBUG_H

#include <cstdlib>
#include <iostream>
#include <string>

#define DEBUG 1
#if DEBUG
   #define ASSRT(CONDITION, MSSG) if(!(CONDITION)) {std::cout << MSSG; exit(-1);}
   #define YELL(MSSG) std::cout << MSSG;
#else 
   #define ASSERT(CONDITION, MSSG)
   #define YELL(MSSG)
#endif

#endif//DEBUG_H
