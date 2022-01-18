%{
    #include "calc.tab.h"
%}

%option noyywrap
%%

[ \t]+ { }
\n return EOL;
\+ return ADD;
- return SUB;
\* return MUL;
\/ return DIV;
\^ return POW;
\( return LPAREN;
\) return RPAREN;
abs return ABS;
round return ROUND;
floor return FLOOR;
ceil return CEIL;
sqrt return SQRT;
ln return LN;
sin return SIN;
cos return COS;
tan return TAN;
e return E;
pi return PI;
[0-9]+(\.[0-9]*)?|\.[0-9]+ { yylval = atof(yytext); return NUM; }
. exit(1);
%%

int main() {
    char* line;
    size_t size;
    for(;;) {
        line = NULL;
        size = 0;
        if(getline(&line, &size, stdin) < 0) {
            return 0;
        }
        YY_BUFFER_STATE bs = yy_scan_string(line);
        yy_switch_to_buffer(bs);
        yyparse();
        yy_delete_buffer(bs);
    }
}
