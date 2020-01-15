module Main(main) where

pair :: [a] -> [(a, a)]
pair xs = zip xs (tail xs)

sorted :: Ord a => [a] -> Bool
sorted xs = and [ x <= y | (x, y) <- pair xs]

main :: IO ()
main = do
  putStrLn $ "zip [1..5] [1..5] = " ++ (show $ zip [1..5] [1..5])
  putStrLn $ "zip [1..4] [1..5] = " ++ (show $ zip [1..4] [1..5])
  putStrLn $ "zip [1..5] [1..4] = " ++ (show $ zip [1..5] [1..4])
  putStrLn $ "zip \"abc\" [1..4] = " ++ (show $ zip "abc" [1..4])
  putStrLn $ "pair [1..5] = " ++ (show $ pair [1..5])
  putStrLn $ "sorted [1..5] = " ++ (show $ sorted [1..5])

