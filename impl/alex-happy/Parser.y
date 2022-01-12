{
module Parser where

import Lexer (Token (..))
}

%name parseExpr
%tokentype { Token }
%error { error "" }

%token
  '+' { Add }
  '-' { Sub }
  '*' { Mul }
  '/' { Div }
  '^' { Pow }
  '(' { Lparen }
  ')' { Rparen }
  abs { Abs }
  round { Round }
  floor { Floor }
  ceil { Ceil }
  sqrt { Sqrt }
  ln { Ln }
  sin { Sin }
  cos { Cos }
  tan { Tan }
  e { E }
  pi { Pi }
  num { Num $$ }

%left '+' '-'
%left '*' '/'
%right '^'
%nonassoc prefix
%%

Expr
  : Expr '+' Expr { $1 + $3 }
  | Expr '-' Expr { $1 - $3 }
  | Expr '*' Expr { $1 * $3 }
  | Expr '/' Expr { $1 / $3 }
  | Expr '^' Expr { $1 ** $3 }
  | '(' Expr ')' { $2 }
  | abs '(' Expr ')' { abs $3 }
  | round '(' Expr ')' { fromIntegral $ round $3 }
  | floor '(' Expr ')' { fromIntegral $ floor $3 }
  | ceil '(' Expr ')' { fromIntegral $ ceiling $3 }
  | sqrt '(' Expr ')' { sqrt $3 }
  | ln '(' Expr ')' { log $3 }
  | sin '(' Expr ')' { sin $3 }
  | cos '(' Expr ')' { cos $3 }
  | tan '(' Expr ')' { tan $3 }
  | '-' Expr %prec prefix { - $2 }
  | '+' Expr %prec prefix { $2 }
  | e { exp 1 }
  | pi { pi }
  | num { $1 }
