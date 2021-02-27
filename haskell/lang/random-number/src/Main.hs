module Main(main) where

import System.Random
import System.IO

minDie :: Int
minDie = 1

maxDie :: Int
maxDie = 6 

main :: IO ()
main = do
  n <- mapM(\_ -> randomRIO(minDie, maxDie)) (take 5 [1..])
  putStrLn $ show n
  s <- show <$> mapM(\_ -> randomRIO(minDie, maxDie)) (take 5 [1..])
  putStrLn s
  mapM(\_ -> randomRIO(minDie, maxDie)) (take 5 [1..]) >>= (putStrLn . show)
  show <$> mapM(\_ -> randomRIO(minDie, maxDie)) (take 5 [1..]) >>= putStrLn

