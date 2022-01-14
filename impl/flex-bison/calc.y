%{
    #include <math.h>
    #include <stdio.h>
    #include <stdlib.h>

    extern int yylex();

    void yyerror(const char* _) {
        exit(1);
    }
%}

%define api.value.type {double}
%token ADD SUB MUL DIV POW LPAREN RPAREN ABS ROUND FLOOR CEIL SQRT LN SIN COS TAN E PI NUM EOL
%left ADD SUB
%left MUL DIV
%right POW
%nonassoc PREFIX
%start expr
%%

expr: expr1 EOL { printf("%f\n", $1); };

expr1
    : expr1 ADD expr1 { $$ = $1 + $3; }
    | expr1 SUB expr1 { $$ = $1 - $3; }
    | expr1 MUL expr1 { $$ = $1 * $3; }
    | expr1 DIV expr1 { $$ = $1 / $3; }
    | expr1 POW expr1 { $$ = pow($1, $3); }
    | LPAREN expr1 RPAREN { $$ = $2; }
    | ABS LPAREN expr1 RPAREN { $$ = fabs($3); }
    | ROUND LPAREN expr1 RPAREN { $$ = round($3); }
    | FLOOR LPAREN expr1 RPAREN { $$ = floor($3); }
    | CEIL LPAREN expr1 RPAREN { $$ = ceil($3); }
    | SQRT LPAREN expr1 RPAREN { $$ = sqrt($3); }
    | LN LPAREN expr1 RPAREN { $$ = log($3); }
    | SIN LPAREN expr1 RPAREN { $$ = sin($3); }
    | COS LPAREN expr1 RPAREN { $$ = cos($3); }
    | TAN LPAREN expr1 RPAREN { $$ = tan($3); }
    | SUB expr1 %prec PREFIX { $$ = - $2; }
    | ADD expr1 %prec PREFIX { $$ = $2; }
    | E { $$ = M_E; }
    | PI { $$ = M_PI; }
    | NUM { $$ = $1; }
    ;
