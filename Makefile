# builds calc++

CXX = clang++
LEX = flex
YACC = bison

CXXFLAGS = -W -Wall -Wextra -g

HEADERS = driver.hh parser.hh scanner.hh FlexLexer.h location.hh

all: calc++

# Generate scanner and parser 

parser.cc: parser.y
	$(YACC) -o parser.cc --defines=parser.hh parser.y

scanner.cc: scanner.l
	$(LEX) -o scanner.cc scanner.l

# Compile and link c++ files

calc++: calc++.cc driver.cc parser.cc scanner.cc
	$(CXX) $(CXXFLAGS) -o calc++ calc++.cc \
	driver.cc parser.cc scanner.cc

clean: 
	rm -rf calc++ calc++.dSYM

extraclean: clean 
	rm -f parser.cc parser.h scanner.cc
