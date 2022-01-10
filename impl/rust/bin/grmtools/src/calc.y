%start Expr
%%

Expr -> f64
    : Expr "+" Expr1 { $1 + $3 }
    | Expr "-" Expr1 { $1 - $3 }
    | Expr1 { $1 }
    ;

Expr1 -> f64
    : Expr1 "*" Expr2 { $1 * $3 }
    | Expr1 "/" Expr2 { $1 / $3 }
    | Expr2 { $1 }
    ;

Expr2 -> f64
    : Expr3 "^" Expr2 { $1.powf($3) }
    | Expr3 { $1 }
    ;

Expr3 -> f64
    : "(" Expr ")" { $2 }
    | "abs" "(" Expr ")" { $3.abs() }
    | "round" "(" Expr ")" { $3.round() }
    | "floor" "(" Expr ")" { $3.floor() }
    | "ceil" "(" Expr ")" { $3.ceil() }
    | "sqrt" "(" Expr ")" { $3.sqrt() }
    | "ln" "(" Expr ")" { $3.ln() }
    | "sin" "(" Expr ")" { $3.sin() }
    | "cos" "(" Expr ")" { $3.cos() }
    | "tan" "(" Expr ")" { $3.tan() }
    | "-" Expr3 { - $2 }
    | "+" Expr3 { $2 }
    | "e" { E }
    | "pi" { PI }
    | "num" { $lexer.span_str($1.unwrap().span()).parse().unwrap() }
    ;
%%

use std::f64::consts::{E, PI};
