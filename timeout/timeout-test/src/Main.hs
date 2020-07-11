module Main where

import Control.Concurrent
import System.Timeout

main :: IO ()
main = do
    timeout 1000000 (threadDelay 1000 *> pure "finished on time") >>= print 
    timeout 1000000 (threadDelay 2000000 *> pure "miss the deadline") >>= print 
    return ()
	
