module Main (main) where

import Control.Concurrent (forkFinally)
import qualified Control.Exception as E
import Control.Monad (unless, forever, void)
import qualified Data.ByteString as S
import Network.Socket
import Network.Socket.ByteString (recv, sendAll)

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
    handle lock clientaddr "syslogtcpserver.hs: client connnected"
    forkIO $ procMessages lock connsock clientaddr
    procRequests lock mastersock
    
procMessages :: MVar () -> Socket -> SockAddr -> IO ()
procMessages lock connsock clientaddr = do
    connhdl <- socketToHandle connsock ReadMode
    hSetBuffering connhdl LineBuffering
    messages <- hGetContents connhdl
    mapM_ (handle lock clientaddr) (lines messages)
    hClose connhdl
    handle lock clientaddr "syslogtcpserver.hs: client disconnected"

handle :: MVar () -> HandlerFunc
handle lock clientaddr msg =
    withMVar lock (\a -> plainHandler clientaddr msg >> return a)
    
plainHandler :: HandlerFunc
plainHandler addr msg = 
    putStrLn $ "From " ++ show addr ++ ": " ++ msg    

main :: IO ()
main = do
    print "local machine, port 4444"
    addrinfos <- getAddrInfo                     
                 (Just (defaultHints {addrFlags = [AI_PASSIVE]}))                    
                 Nothing (Just "4444")
    mapM_ (print) addrinfos

    print "cn.bing.com, https"
    baidu <- getAddrInfo                     
                 (Just (defaultHints {addrFlags = [AI_PASSIVE]}))                    
                 (Just "cn.bing.com") (Just "https")
    mapM_ (print) baidu

    let addr = head $ filter (\ addr -> (addrFamily addr) == AF_INET && (addrSocketType addr) == Stream) addrinfos

    sock <- socket (addrFamily addr) Stream defaultProtocol
    bind sock (addrAddress addr) 
    listen sock 5

    lock <- newMVar ()

    procRequests lock sock

