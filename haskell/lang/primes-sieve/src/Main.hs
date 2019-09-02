primes :: Int -> [Int]
primes n = if n < 2 then []
  else sieve [2..n]

sieve :: [Int] -> [Int]
sieve []     = []
sieve (p:xs) = [p] ++ sieve ps
  where ps = [x | x <- xs, not(x `mod` p == 0)]

main :: IO ()
main = do
  putStrLn $ show (primes 100)

