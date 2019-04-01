%{ /* -*- C++ -*- */
  #include <cerrno>
  #include <climits>
  #include <cstdlib>
  #include <cstring>
  #include <string>
  #include "scanner.hh"
  #include "driver.hh"
%}

%option noyywrap nounput noinput batch debug c++
%option prefix="Example"
%{
  yy::parser::symbol_type
  make_NUMBER (const std::string &s, const yy::parser::location_type &loc);
%}

id     [a-zA-Z][a-zA-Z_0-9]*
int    [0-9]+
blank  [ \t\r]

%{
  #define YY_USER_ACTION loc.columns(yyleng);
%}
%%
%{
  yy::location& loc = drv.location;
  loc.step();
%}
{blank}+  loc.step();
\n+       loc.lines(yyleng); loc.step();

"-"       return yy::parser::make_MINUS   (loc);
"+"       return yy::parser::make_PLUS    (loc);
"*"        return yy::parser::make_STAR   (loc);
"/"        return yy::parser::make_SLASH  (loc);
"("        return yy::parser::make_LPAREN (loc);
")"        return yy::parser::make_RPAREN (loc);
":="       return yy::parser::make_ASSIGN (loc);

{int}      return make_NUMBER (yytext, loc);
{id}       return yy::parser::make_IDENTIFIER (yytext, loc);
.          {
             throw yy::parser::syntax_error
               (loc, "invalid character: " + std::string(yytext));
}
<<EOF>>    return yy::parser::make_END (loc);
%%
yy::parser::symbol_type
make_NUMBER (const std::string &s, const yy::parser::location_type& loc)
{
  errno = 0;
  long n = strtol (s.c_str(), NULL, 10);
  if (! (INT_MIN <= n && n <= INT_MAX && errno != ERANGE))
    throw yy::parser::syntax_error (loc, "integer is out of range: " + s);
  return yy::parser::make_NUMBER ((int) n, loc);
}

Scanner::Scanner(std::istream* in,
                 std::ostream* out)
  : ExampleFlexLexer(in, out)
{
}

Scanner::~Scanner()
{
}

void Scanner::set_debug(bool b)
{
  yy_flex_debug = b;
}

#ifdef yylex
#undef yylex
#endif

int ExampleFlexLexer::yylex()
{
  std::cerr << "in yyFlexLexer::yylex() !" << std::endl;
  return 0;
}

