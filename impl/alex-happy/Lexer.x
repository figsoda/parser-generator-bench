{
module Lexer where
}

%wrapper "basic"

tokens :-
  [\ \t]+ ;
  \+ { const Add }
  \- { const Sub }
  \* { const Mul }
  \/ { const Div }
  \^ { const Pow }
  \( { const Lparen }
  \) { const Rparen }
  abs { const Abs }
  round { const Round }
  floor { const Floor }
  ceil { const Ceil }
  sqrt { const Sqrt }
  ln { const Ln }
  sin { const Sin }
  cos { const Cos }
  tan { const Tan }
  e { const E }
  pi { const Pi }
  [0-9]+\.[0-9]+ { Num . read }
  [0-9]+\. { Num . read . (++ "0") }
  \.[0-9] { Num . read . ('0' :)}
  [0-9]+ { Num . read }

{
data Token
  = Add | Sub | Mul | Div | Pow | Lparen | Rparen
  | Abs | Round | Floor | Ceil | Sqrt | Ln | Sin | Cos | Tan
  | E | Pi | Num Double
}
