module Main(main) where

import Test.Hspec

findMax :: [Int] -> Maybe Int
findMax [] = Nothing
findMax xs = Just m
  where m = foldl1 (\p x -> if p > x then p else x) xs

main :: IO ()
main = hspec $ do
  describe "findMax should" $ do
    it "find Nothing in []" $ do
      findMax [] `shouldBe` Nothing
    it "find Just 9 in [1,9,8,3]" $ do
      findMax [1,9,8,3] `shouldBe` Just 9

