module Main(main) where

import Test.Hspec
import Test.QuickCheck

main :: IO ()
main = hspec $ do
  describe "A Plus(+) operation should" $ do
    it "x + 1 is always greater than x" $ do
      property $ \x -> x + 1 > (x :: Int)
