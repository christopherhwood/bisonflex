#include <fstream>
#include <sstream>

#include "driver.hh"
#include "scanner.hh"

driver::driver ()
  : trace_parsing (false), trace_scanning (false)
{
  variables["one"] = 1;
  variables["two"] = 2;
}

int 
driver::parse_stream(std::istream& in, const std::string& sname)
{
  file = sname;
  location.initialize(&file);
  
  Scanner scanner(&in);
  scanner.set_debug(trace_scanning);
  this->lexer = &scanner;

  yy::parser parse (*this);
  parse.set_debug_level (trace_parsing);
  int res = parse ();
  return res;
}

int
driver::parse (const std::string &f)
{
  std::ifstream in(f.c_str());
  if (!in.good()) return 0;
  return parse_stream(in, f);
}
