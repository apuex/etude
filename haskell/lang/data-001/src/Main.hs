-- Just ignore the quasiquote stuff for now, and that shamlet thing.
-- It will be explained later.
{-# LANGUAGE QuasiQuotes #-}

data Person = Person
  { 
    name :: String
  , age :: Int
  } deriving (Eq, Show, Read)

showPerson:: IO ()
showPerson = putStrLn $ show person
  where
    person = Person "Michael" 26

factors :: Int -> [Int]
factors n = [x | x <- [1..n], n `mod` x == 0]

primes :: Int -> [Int]
primes x = if x < 2 then []
           else sieve [2..x]

sieve :: [Int] -> [Int]
sieve [] = []
sieve (p:xs) = [p] ++ sieve ps
  where ps = [x | x <- xs, not(x `mod` p == 0)]

main :: IO ()
main = do
  putStrLn $ show (primes 65536)
  --  putStrLn $ show (factors 100)
