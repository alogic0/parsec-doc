module Main where

import Data.List
import System.Environment

main = do
 fs <- getArgs
 mapM_ lexifile fs

lexifile f = do
 c <- readFile f
 mapM_ putStrLn $ unfoldr lexemes c

lexemes "" = Nothing
lexemes str = case lex str of
                  [] -> lexemes (tail str)
                  smthing -> Just (head smthing)
