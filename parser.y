%skeleton "lalr1.cc" /* -*- C++ -*- */
%require "3.3"
%start unit
%defines
%define api.token.constructor
%define api.value.type variant
%define parse.assert
%code requires {
  #include <string>
  class driver;
}
// The parsing context.
%locations
%define parse.trace
%define parse.error verbose
%param { driver& drv }
%token
  END  0  "end of file"
  ASSIGN  ":="
  MINUS   "-"
  PLUS    "+"
  STAR    "*"
  SLASH   "/"
  LPAREN  "("
  RPAREN  ")"
;

%token <std::string> IDENTIFIER "identifier"
%token <int> NUMBER "number"
%type  <int> exp

%printer { yyo << $$; } <*>;

%code {
  #include "driver.hh"
  #include "scanner.hh"
  #undef yylex
  #define yylex drv.lexer->lex
}
%%

unit: assignments exp  { drv.result = $2; };

assignments:
  %empty                 {}
| assignments assignment {};

assignment:
  "identifier" ":=" exp { drv.variables[$1] = $3; };

%left "+" "-";
%left "*" "/";
exp:
  "number"
| "identifier"  { $$ = drv.variables[$1]; }
| exp "+" exp   { $$ = $1 + $3; }
| exp "-" exp   { $$ = $1 - $3; }
| exp "*" exp   { $$ = $1 * $3; }
| exp "/" exp   { $$ = $1 / $3; }
| "(" exp ")"   { $$ = $2; }
%%

void
yy::parser::error (const location_type& l, const std::string& m)
{
  std::cerr << l << ": " << m << '\n';
}
