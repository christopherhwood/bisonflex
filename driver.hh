#ifndef DRIVER_HH
#define DRIVER_HH
#include <string>
#include <map>
#include "parser.hh"


// Conducting the whole scanning and parsing of Calc++.
class driver
{
public:
  driver ();

  std::map<std::string, int> variables;

  int result;

  int parse_stream(std::istream& in, const std::string& sname);
  // Run the parser on file F.  Return 0 on success.
  int parse (const std::string& f);
  // The name of the file being parsed.
  std::string file;
  // Whether to generate parser debug traces.
  bool trace_parsing;

  // Handling the scanner.
  class Scanner* lexer;
  // Whether to generate scanner debug traces.
  bool trace_scanning;
  // The token's location used by the scanner
  yy::location location;
};
#endif // ! DRIVER_HH
