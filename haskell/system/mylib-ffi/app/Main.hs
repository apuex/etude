module Main where

import Mylib.Base.Types
import Mylib.Base.C
import Mylib.Base

main :: IO ()
main = do
    let foo = MyFoo { fooX = 1, fooY = 2.0 }
    putStrLn $ "before setFoo: " ++ show foo
    setFoo foo >>= print 
    putStrLn $ "after setFoo/before updateFoo: " ++ show foo
    updateFoo foo >>= \ p -> putStrLn $ "after updateFoo: " ++ show p
    --let bar = MyBar { barX = 1, barY = "Hello, World!" }
    --putStrLn "Hi."
    --getBar bar >>= print
    
