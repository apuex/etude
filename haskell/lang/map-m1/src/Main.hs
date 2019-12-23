module Main(main) where

import Control.Monad
import Text.Printf

list :: Int -> [Int]
list n = if n > 1 then [1..n]
         else []

main :: IO ()
main = do
  mapM_ (\ x -> printf "%6d  %s\n" x (show x)) (list 10)

