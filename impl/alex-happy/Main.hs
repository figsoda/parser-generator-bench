module Main where

import System.IO (isEOF)

import Lexer (alexScanTokens)
import Parser (parseExpr)

main :: IO ()
main = do
  eof <- isEOF
  if eof then pure () else do
    print =<< parseExpr <$> alexScanTokens <$> getLine
    main
