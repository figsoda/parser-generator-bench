module Main where

import Lexer (alexScanTokens)
import Parser (parseExpr)

main :: IO ()
main = do
  print =<< parseExpr <$> alexScanTokens <$> getLine
  main
