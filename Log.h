#ifndef LOG_H
#define LOG_H

#include "Debug.h"
#include <vector>

struct LogEntry {
   std::string time_start, time_end;
   std::string category;
   std::string message;
};

class Log {
public:
   std::vector<LogEntry> entries;
   Log() {}
   void read_from(std::string filename);
};

#endif//LOG_H
