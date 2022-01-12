try
  while true do
    print_float (Parser.expr Lexer.token (Lexing.from_string (read_line ())));
    print_newline ();
    flush stdout
  done
with End_of_file -> exit 0
