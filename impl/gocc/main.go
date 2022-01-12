package main

import (
    "calc-gocc/lexer"
    "calc-gocc/parser"
    "bufio"
    "fmt"
    "os"
)

func main() {
    p := parser.NewParser()
    scanner := bufio.NewScanner(os.Stdin)
    for scanner.Scan() {
        if scanner.Err() != nil {
            os.Exit(1)
        }

        x, err := p.Parse(lexer.NewLexer(scanner.Bytes()))

        if err != nil {
            os.Exit(1)
        }

        fmt.Println(x)
    }
}
