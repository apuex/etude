module Main where
import Text.Printf

area d = pi * (r * r)
  where r  = d / 2

main :: IO ()
main = do
  putStrLn "Hello, World!"
  putStr "Hello, World!"
  putStr "Hello, World!"
  putStrLn "Hello, World!"

  let d = 10
  putStrLn ("area of circle with diameter = " ++ show(d) ++ " is: " ++ show (area(d)))

