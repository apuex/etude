module Main(main) where

allNumbers :: [Integer]
allNumbers = allNumbersFrom 1

allNumbersFrom :: Integer -> [Integer]
allNumbersFrom n = n : allNumbersFrom (n + 1)

main :: IO ()
main = do
  let zipped = zip allNumbers "abcd"
  putStrLn $ show zipped

