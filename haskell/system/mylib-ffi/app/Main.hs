module Main where

import Mylib.Base.Types
import Mylib.Base.C
import Mylib.Base
import Text.Printf
import Foreign.C.String
import Foreign.C.Types

main :: IO ()
main = do

    let foo = MyFoo { fooX = 1, fooY = 2.0 }
    putStrLn $ "[Main.hs]: before setFoo: " ++ show foo
    setFoo foo >>= printf "[Main.hs]: %d\n" 
    putStrLn $ "[Main.hs]: after setFoo/before updateFoo: " ++ show foo
    updateFoo foo >>= \ p -> putStrLn $ "[Main.hs]: after updateFoo: " ++ show p
    let bar = MyBar { barX = 1, barY = "Hello, World!" }
    setBar bar (\ p -> putStrLn $ "[Main.hs]: setBar: " ++ show foo) >>= printf "[Main.hs]: %d\n"

    getBar >>= \ p -> do
        printf "[Main.hs]: barX -> %s\n" $ show (barX p)
        printf "[Main.hs]: barY -> %s\n" $ (barY p)
    updateBar bar >>= \ p -> putStrLn $ "[Main.hs]: after updateBar: " ++ show p
    version >>= printf "[Main.hs]: %s\n"
