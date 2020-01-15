odds :: Int -> [Int]
odds n = [x | x <- map f [1..m], x <= n]
  where f x = x * 2 - 1
        m   = (n `div` 2) + (n `mod` 2)

main :: IO ()
main = do
  putStrLn $ "odds not greater than 100: " ++ show (odds 100)
  putStrLn $ "odds not greater than  99: " ++ show (odds 100)

