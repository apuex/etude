module Main(primes, main) where

import Test.Hspec

primes :: Int -> [Int]
primes n = if n < 2 then []
  else sieve [2..n]

sieve :: [Int] -> [Int]
sieve []     = []
sieve (p:xs) = [p] ++ sieve ps
  where ps = [x | x <- xs, not(x `mod` p == 0)]

main :: IO ()
main = hspec $ do
  describe "primes-sieve" $ do
    it "primes within 10 should be [2,3,5,7]" $ do
      primes 10 `shouldBe` [2,3,5,7]
    it "primes within 100 should be [2,3,5,7,11,13,17,19,23,29,31,37,41,43,47,53,59,61,67,71,73,79,83,89,97]" $ do
      primes 100 `shouldBe` [2,3,5,7,11,13,17,19,23,29,31,37,41,43,47,53,59,61,67,71,73,79,83,89,97]

