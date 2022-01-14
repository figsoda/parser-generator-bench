grammar calc;

@header {
    import (
        "math"
        "os"
    )

    func _() {
        _, _ = math.E, os.Exit
    }
}

expr: expr1 EOF { fmt.Println($expr1.n); };

expr1 returns [float64 n]
    : x=expr1 '+' y=expr2 { $n = $x.n + $y.n; }
    | x=expr1 '-' y=expr2 { $n = $x.n - $y.n; }
    | expr2 { $n = $expr2.n; }
    ;

expr2 returns [float64 n]
    : x=expr2 '*' y=expr3 { $n = $x.n * $y.n; }
    | x=expr2 '/' y=expr3 { $n = $x.n / $y.n; }
    | expr3 { $n = $expr3.n; }
    ;

expr3 returns [float64 n]
    : x=expr4 '^' y=expr3 { $n = math.Pow($x.n, $y.n); }
    | expr4 { $n = $expr4.n; }
    ;

expr4 returns [float64 n]
    : '(' expr1 ')' { $n = $expr1.n; }
    | 'abs' '(' expr1 ')' { $n = math.Abs($expr1.n); }
    | 'round' '(' expr1 ')' { $n = math.Round($expr1.n); }
    | 'floor' '(' expr1 ')' { $n = math.Floor($expr1.n); }
    | 'ceil' '(' expr1 ')' { $n = math.Ceil($expr1.n); }
    | 'sqrt' '(' expr1 ')' { $n = math.Sqrt($expr1.n); }
    | 'ln' '(' expr1 ')' { $n = math.Log($expr1.n); }
    | 'sin' '(' expr1 ')' { $n = math.Sin($expr1.n); }
    | 'cos' '(' expr1 ')' { $n = math.Cos($expr1.n); }
    | 'tan' '(' expr1 ')' { $n = math.Tan($expr1.n); }
    | '-' expr4 { $n = - $expr4.n; }
    | '+' expr4 { $n = $expr4.n; }
    | 'e' { $n = math.E; }
    | 'pi' { $n = math.Pi; }
    | NUM {
        n, err := strconv.ParseFloat($NUM.text, 10);
        $n = n
        if err != nil {
            os.Exit(1)
        }
    }
    ;

NUM: [0-9]+ ('.' [0-9]*)? | '.' [0-9]+;
WS: [ \t]+ -> skip;
ERROR: .;
