#include <iostream>

#include "antlr4-runtime.h"
#include "calcLexer.h"
#include "calcParser.h"

using namespace antlr4;

int main() {
    for (std::string line; std::getline(std::cin, line);) {
        ANTLRInputStream input(line);
        calcLexer lexer(&input);
        CommonTokenStream tokens(&lexer);
        calcParser parser(&tokens);
        parser.removeErrorListeners();
        parser.setErrorHandler(std::make_shared<BailErrorStrategy>());
        parser.expr();
    }
}
