grammar calc;

@header {
    #include <cmath>
    #include <iostream>
    #include <numbers>
}

expr: expr1 EOF { std::cout << $expr1.n << std::endl; };

expr1 returns [double n]
    : x=expr1 '+' y=expr2 { $n = $x.n + $y.n; }
    | x=expr1 '-' y=expr2 { $n = $x.n - $y.n; }
    | expr2 { $n = $expr2.n; }
    ;

expr2 returns [double n]
    : x=expr2 '*' y=expr3 { $n = $x.n * $y.n; }
    | x=expr2 '/' y=expr3 { $n = $x.n / $y.n; }
    | expr3 { $n = $expr3.n; }
    ;

expr3 returns [double n]
    : x=expr4 '^' y=expr3 { $n = std::pow($x.n, $y.n); }
    | expr4 { $n = $expr4.n; }
    ;

expr4 returns [double n]
    : '(' expr1 ')' { $n = $expr1.n; }
    | 'abs' '(' expr1 ')' { $n = std::abs($expr1.n); }
    | 'round' '(' expr1 ')' { $n = std::round($expr1.n); }
    | 'floor' '(' expr1 ')' { $n = std::floor($expr1.n); }
    | 'ceil' '(' expr1 ')' { $n = std::ceil($expr1.n); }
    | 'sqrt' '(' expr1 ')' { $n = std::sqrt($expr1.n); }
    | 'ln' '(' expr1 ')' { $n = std::log($expr1.n); }
    | 'sin' '(' expr1 ')' { $n = std::sin($expr1.n); }
    | 'cos' '(' expr1 ')' { $n = std::cos($expr1.n); }
    | 'tan' '(' expr1 ')' { $n = std::tan($expr1.n); }
    | '-' expr4 { $n = - $expr4.n; }
    | '+' expr4 { $n = $expr4.n; }
    | 'e' { $n = std::numbers::e; }
    | 'pi' { $n = std::numbers::pi; }
    | NUM { $n = atof($NUM.text.c_str()); }
    ;

NUM: [0-9]+ ('.' [0-9]*)? | '.' [0-9]+;
WS: [ \t]+ -> skip;
ERROR: .;
