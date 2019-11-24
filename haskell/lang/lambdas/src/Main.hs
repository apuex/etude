double :: [Int] -> [Int]
double xs = map (\x -> x * 2) xs


main :: IO ()
main = do
  putStrLn $ show (double [1..5])


