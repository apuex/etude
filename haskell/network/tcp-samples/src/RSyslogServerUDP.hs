module Main(main) where

import           Data.Bits
import           Network.Socket hiding (recvFrom)
import           Network.Socket.ByteString
import qualified Data.ByteString.UTF8 as UTF8
import           Data.List
import           GHC.IO.Encoding (getLocaleEncoding, setLocaleEncoding, mkTextEncoding)

type HandlerFunc = SockAddr -> String -> IO ()

serveLog :: String              -- ^ Port number or name; 514 is default
         -> HandlerFunc         -- ^ Function to handle incoming messages
         -> IO ()
serveLog port handlerfunc = withSocketsDo $
    do -- Look up the port.  Either raises an exception or returns
       -- a nonempty list.  
       addrinfos <- getAddrInfo 
                    (Just (defaultHints {addrFlags = [AI_PASSIVE]}))
                    Nothing (Just port)
       let serveraddr = head addrinfos

       -- Create a socket
       sock <- socket (addrFamily serveraddr) Datagram defaultProtocol

       -- Bind it to the address we're listening to
       bind sock (addrAddress serveraddr)

       -- Loop forever processing incoming data.  Ctrl-C to abort.
       procMessages sock
    where procMessages sock =
              do -- Receive one UDP packet, maximum length 10240 bytes,
                 -- and save its content into msg and its source
                 -- IP and port into addr
                 (msg, addr) <- recvFrom sock 10240
                 -- Handle it
                 handlerfunc addr $ UTF8.toString msg
                 -- And process more messages
                 procMessages sock

-- A simple handler that prints incoming packets
plainHandler :: HandlerFunc
plainHandler addr msg = 
    putStrLn $ "From " ++ show addr ++ ": " ++ msg

main :: IO ()
main = do
    getLocaleEncoding >>= print
    serveLog "514" plainHandler

