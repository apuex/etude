factors :: Int -> [Int]
factors n = if n < 1 then []
  else [x | x <- [1..n], n `mod` x == 0]

main :: IO ()
main = do
  putStrLn $ show (factors 100)

