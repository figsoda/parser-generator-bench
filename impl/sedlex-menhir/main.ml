open Calc

let rec token buf =
  let digit = [%sedlex.regexp? '0' .. '9'] in
  match%sedlex buf with
  | Plus (' ' | '\t') -> token buf
  | '+' -> ADD
  | '-' -> SUB
  | '*' -> MUL
  | '/' -> DIV
  | '^' -> POW
  | '(' -> LPAREN
  | ')' -> RPAREN
  | "abs" -> ABS
  | "round" -> ROUND
  | "ceil" -> CEIL
  | "sqrt" -> SQRT
  | "ln" -> LN
  | "sin" -> SIN
  | "cos" -> COS
  | "tan" -> TAN
  | "e" -> E
  | "pi" -> PI
  | Plus digit, Opt ('.', Star digit) | '.', Plus digit -> NUM (float_of_string (Sedlexing.Utf8.lexeme buf))
  | eof -> EOF
  | _ -> exit 1
;;

try
  while true do
    print_float (MenhirLib.Convert.Simplified.traditional2revised expr (Sedlexing.with_tokenizer token (Sedlexing.Utf8.from_string (read_line ()))));
    print_newline ();
    flush stdout
  done
with End_of_file -> exit 0
