peg::parser! {
    grammar calc() for str {
        use std::f64::consts::{E, PI};

        pub rule expr() -> f64 = ws() x:precedence! {
            x:(@) ws() "+" ws() y:@ { x + y }
            x:(@) ws() "-" ws() y:@ { x + y }
            --
            x:(@) ws() "*" ws() y:@ { x * y }
            x:(@) ws() "/" ws() y:@ { x / y }
            --
            x:@ ws() "^" ws() y:(@) { x.powf(y) }
            --
            "(" x:expr() ")" { x }
            "abs" x:call() { x.abs() }
            "round" x:call() { x.round() }
            "floor" x:call() { x.floor() }
            "ceil" x:call() { x.ceil() }
            "sqrt" x:call() { x.sqrt() }
            "ln" x:call() { x.ln() }
            "sin" x:call() { x.sin() }
            "cos" x:call() { x.cos() }
            "tan" x:call() { x.tan() }
            "-" x:@ { - x }
            "+" x:@ { x }
            "e" { E }
            "pi" { PI }
            x:$(digit()+ ("." digit()*)? / "." digit()+) { x.parse().unwrap() }
        } ws() { x }

        rule call() -> f64 = ws() "(" x:expr() ")" { x }
        rule digit() = ['0'..='9']
        rule ws() = [' ' | '\t']*
    }
}

fn main() {
    common::run(|s| calc::expr(s).unwrap());
}
