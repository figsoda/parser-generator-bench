{
  open Parser
}

rule token = parse
  | [' ' '\t'] { token lexbuf }
  | '+' { ADD }
  | '-' { SUB }
  | '*' { MUL }
  | '/' { DIV }
  | '^' { POW }
  | '(' { LPAREN }
  | ')' { RPAREN }
  | "abs" { ABS }
  | "round" { ROUND }
  | "ceil" { CEIL }
  | "sqrt" { SQRT }
  | "ln" { LN }
  | "sin" { SIN }
  | "cos" { COS }
  | "tan" { TAN }
  | "e" { E }
  | "pi" { PI }
  | ['0'-'9']+ ('.' ['0'-'9']*)? | '.' ['0'-'9']+ as s { NUM (float_of_string s) }
  | eof { EOF }
