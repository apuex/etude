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
    handle lock clientaddr $ "[" ++ show clientaddr ++ "]: " ++ "client connected."
    forkIO $ procMessages lock connsock clientaddr
    procRequests lock mastersock
    
procMessages :: MVar () -> Socket -> SockAddr -> IO ()
procMessages lock connsock clientaddr = do
    connhdl <- socketToHandle connsock ReadMode
    hSetBuffering connhdl LineBuffering
    messages <- hGetContents connhdl
    mapM_ (handle lock clientaddr) (lines messages)
    hClose connhdl
    handle lock clientaddr $ "[" ++ show clientaddr ++ "]: " ++ "client disconnected."

handle :: MVar () -> HandlerFunc
handle lock clientaddr msg =
    withMVar lock (\a -> plainHandler clientaddr msg >> return a)
    
plainHandler :: HandlerFunc
plainHandler addr msg = 
    putStrLn $ "[" ++ show addr ++ "]: " ++ msg    

main :: IO ()
main = do
    let port = "2016"
    print $ "ALL host(s), port " ++ port
    addrinfos <- getAddrInfo                     
                 (Just (defaultHints {addrFlags = [AI_PASSIVE]}))                    
                 Nothing (Just port)
    mapM_ (print) addrinfos

    let addr = head $ filter (\ addr -> 
            (addrFamily addr) == AF_INET
            -- && (addrSocketType addr) == Stream
            ) addrinfos

    sock <- socket (addrFamily addr) Stream defaultProtocol
    bind sock (addrAddress addr) 
    listen sock 5

    lock <- newMVar ()

    procRequests lock sock

