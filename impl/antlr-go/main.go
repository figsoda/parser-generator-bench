package main

import (
    "github.com/antlr/antlr4/runtime/Go/antlr"
    "calc-antlr-go/parser"
    "bufio"
    "os"
)

func main() {
    scanner := bufio.NewScanner(os.Stdin)
    for scanner.Scan() {
        if scanner.Err() != nil {
            os.Exit(1)
        }

        p := parser.NewcalcParser(antlr.NewCommonTokenStream(parser.NewcalcLexer(antlr.NewInputStream(scanner.Text())), 0))
        p.SetErrorHandler(antlr.NewBailErrorStrategy())
        p.Expr()
    }
}
