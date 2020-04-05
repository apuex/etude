module Main (main) where

import Data.Bits
import Network.Socket
import Network.BSD
import Data.List
import Control.Concurrent
import Control.Concurrent.MVar
import System.IO


type HandlerFunc = SockAddr -> String -> IO ()

procRequests :: MVar () -> Socket -> IO ()
procRequests lock mastersock = do 
    (connsock, clientaddr) <- accept mastersock
    handle lock clientaddr $ "client connnected: " ++ show clientaddr
    forkIO $ procMessages lock connsock clientaddr
    procRequests lock mastersock
    
procMessages :: MVar () -> Socket -> SockAddr -> IO ()
procMessages lock connsock clientaddr = do
    connhdl <- socketToHandle connsock ReadMode
    hSetBuffering connhdl LineBuffering
    messages <- hGetContents connhdl
    mapM_ (handle lock clientaddr) (lines messages)
    hClose connhdl
    handle lock clientaddr $ "client disconnected: " ++ show clientaddr

handle :: MVar () -> HandlerFunc
handle lock clientaddr msg =
    withMVar lock (\a -> plainHandler clientaddr msg >> return a)
    
plainHandler :: HandlerFunc
plainHandler addr msg = 
    putStrLn $ "From " ++ show addr ++ ": " ++ msg    

main :: IO ()
main = do
    print "host concerto, port 4444"
    addrinfos <- getAddrInfo                     
                 (Just (defaultHints {addrFlags = [AI_PASSIVE]}))                    
                 (Just "concerto") (Just "4444")
    mapM_ (print) addrinfos

    let addr = head $ filter (\ addr -> (addrFamily addr) == AF_INET && (addrSocketType addr) == Stream) addrinfos

    sock <- socket (addrFamily addr) Stream defaultProtocol
    bind sock (addrAddress addr) 
    listen sock 5

    lock <- newMVar ()

    procRequests lock sock

