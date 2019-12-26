module Main(main) where

import Control.Monad
import Data.List
import Text.Printf

list :: Int -> [Int]
list n = if n > 1 then [1..n] else []

plus :: Int -> Int -> IO Int
plus a b = return (a + b)

main :: IO ()
main = do
  let numbers = list 100
  sumWithLambda   <- foldM (\ s i -> return (s + i)) 0 numbers
  sumWithFunction <- foldM plus 0 numbers
  printf "lambda = %d, function = %d\n" sumWithLambda sumWithFunction

