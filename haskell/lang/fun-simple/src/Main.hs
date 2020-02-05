module Main ( main ) where

f1 :: a -> b -> a
f1 a b = a

f2 :: a -> b -> b
f2 a b = b

g :: Num a => a -> a
g x = 0 * x

main :: IO ()
main = do
  let f1g = (f1 g) id 2
  let f2g = (f2 g) id 2
  putStrLn $ "(f1 g) id 2 = " ++ show f1g
  putStrLn $ "(f2 g) id 2 = " ++ show f2g
