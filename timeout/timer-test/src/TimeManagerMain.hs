module Main where

import Control.Monad
import System.TimeManager
import System.IO

main :: IO ()
main = do
    manager <- initialize 5000000
    let repeatAction = do
            putStrLn "timeout"
            handle <- register manager repeatAction
            return ()

    mapM_ (\ _ -> register manager repeatAction) [1..10]
    -- forever $ do
    line1 <- getLine
    putStrLn "time manager stopped"
    stopManager manager
