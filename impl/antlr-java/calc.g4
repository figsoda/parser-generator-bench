grammar calc;

expr: expr1 EOF { System.out.println($expr1.n); };

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
    : x=expr4 '^' y=expr3 { $n = Math.pow($x.n, $y.n); }
    | expr4 { $n = $expr4.n; }
    ;

expr4 returns [double n]
    : '(' expr1 ')' { $n = $expr1.n; }
    | 'abs' '(' expr1 ')' { $n = Math.abs($expr1.n); }
    | 'round' '(' expr1 ')' { $n = Math.round($expr1.n); }
    | 'floor' '(' expr1 ')' { $n = Math.floor($expr1.n); }
    | 'ceil' '(' expr1 ')' { $n = Math.ceil($expr1.n); }
    | 'sqrt' '(' expr1 ')' { $n = Math.sqrt($expr1.n); }
    | 'ln' '(' expr1 ')' { $n = Math.log($expr1.n); }
    | 'sin' '(' expr1 ')' { $n = Math.sin($expr1.n); }
    | 'cos' '(' expr1 ')' { $n = Math.cos($expr1.n); }
    | 'tan' '(' expr1 ')' { $n = Math.tan($expr1.n); }
    | '-' expr4 { $n = - $expr4.n; }
    | '+' expr4 { $n = $expr4.n; }
    | 'e' { $n = Math.E; }
    | 'pi' { $n = Math.PI; }
    | NUM { $n = Double.parseDouble($NUM.text); }
    ;

NUM: [0-9]+ ('.' [0-9]*)? | '.' [0-9]+;
WS: [ \t]+ -> skip;
ERROR: .;
