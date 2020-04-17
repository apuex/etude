module Main where

import System.IO

main :: IO ()
main = putStrLn triplesix 
    where triplesix = map (\ _ -> '6' ) [1..3] 
