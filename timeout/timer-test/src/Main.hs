module Main where

import Control.Concurrent
import Control.Concurrent.Suspend.Lifted
import Control.Concurrent.Timer
import System.IO
import System.Timeout
main :: IO ()
main = do
    timer1 <- oneShotTimer (putStrLn "one last shot") (sDelay 1)
    timer2 <- repeatedTimer (putStrLn "repeated shot") (sDelay 1)
    timeout 1000000 (threadDelay 1000 *> pure "finished on time") >>= print 
    timeout 1000000 (threadDelay 2000000 *> pure "miss the deadline") >>= print 
    line1 <- getLine
    stopTimer timer1
    stopTimer timer2
    putStrLn "timers stopped."
    line2 <- getLine
    return ()
