# bisonflex
Sample bison flex demo based on bison 3.3 and flex 2.6.4

Build by running "make calc++"
Run with "./calc++ test.txt"

This demo is based on both the bison 3.3 calc++ demo and the example here https://github.com/bingmann/flex-bison-cpp-example

I essentially merged the two projects with the help of the bison and flex documentation to make something that works. The existing bison demo didn't compile for me, and the linked example would compile after updating the bison and flex files, but would crash during runtime with a bad access error. 
