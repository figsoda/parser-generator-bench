build:
	antlr calc.g4 -Dlanguage=Cpp
	c++ *.cpp $(RUNTIME_LIB)/lib/libantlr4-runtime.a -I$(RUNTIME_INCLUDE)/include/antlr4-runtime -std=c++20 -O3 -flto -o $(pname)

install:
	install -Dm755 $(pname) -t $(out)/bin
