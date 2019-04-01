// $Id$

#ifndef SCANNER_H
#define SCANNER_H

// Flex expects the signature of yylex to be defined in macro YY_DECL, and 
// the C++ parser expects it to be declared. We can factor both as follows.

#ifndef YY_DECL

#define YY_DECL yy::parser::symbol_type Scanner::lex( driver& drv )
#endif

#ifndef __FLEX_LEXER_H
#define yyFlexLexer ExampleFlexLexer
#include "FlexLexer.h"
#undef yyFlexLexer
#endif

#include "parser.hh"
class driver;

class Scanner : public ExampleFlexLexer 
{
public:
  Scanner(std::istream* arg_yyin = 0,
          std::ostream* arg_yyout = 0);
  virtual ~Scanner();
  virtual yy::parser::symbol_type lex(driver& drv);
  void set_debug(bool b);
};

#endif // SCANNER_H
