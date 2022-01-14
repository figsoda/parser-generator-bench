build:
	antlr calc.g4 -Dlanguage=Cpp
	c++ *.cpp $(RUNTIME_LIB)/lib/libantlr4-runtime.a -I$(RUNTIME_INCLUDE)/include/antlr4-runtime -std=c++20 -O3 -flto -o calc-antlr-cpp

install:
	install -Dm755 calc-antlr-cpp -t $(out)/bin
