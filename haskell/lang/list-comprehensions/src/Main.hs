module Main(main) where

import Data.Char

lowers :: String -> Int
lowers xs = length [x | x <- xs, isLower x]

count :: Char -> String -> Int
count x xs = length [x' | x' <- xs, x' == x]

main :: IO ()
main = do
  let str = "abcde"
  let haskell = "Hello, Haskell World!"
  print $ str!!2
  print $ take 3 str
  print $ length str
  print $ lowers str 
  print $ lowers haskell
  print $ count 'c' str 
  print $ count 'H' haskell

