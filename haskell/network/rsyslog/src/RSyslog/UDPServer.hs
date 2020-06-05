module RSyslog.UDPServer where

import           Chronos
import           Control.Concurrent.MVar
import           Data.Bits
import qualified Data.ByteString.Char8       as BC
import qualified Data.ByteString.UTF8        as UTF8
import           Data.List
import           Network.Socket              hiding (recvFrom)
import           Network.Socket.ByteString
import           System.FilePath
import           System.IO
import           Text.Printf

type HandlerFunc = SockAddr -> BC.ByteString -> IO ()

serveLog ::  MVar Bool
         -> String              -- ^ Port number or name; 514 is default
         -> HandlerFunc         -- ^ Function to handle incoming messages
         -> IO ()
serveLog run port handlerfunc = withSocketsDo $
    do -- Look up the port.  Either raises an exception or returns
       -- a nonempty list.  
       addrinfos <- getAddrInfo 
                    (Just (defaultHints {addrFlags = [AI_PASSIVE]}))
                    Nothing (Just port)
       let serveraddr = head addrinfos

       -- Create a socket
       sock <- socket (addrFamily serveraddr) Datagram defaultProtocol

       -- Bind it to the address we're listening to
       setSocketOption sock ReuseAddr 1
       bind sock (addrAddress serveraddr)

       -- Loop forever processing incoming data.  Ctrl-C to abort.
       procMessages sock
    where procMessages sock =
              do -- Receive one UDP packet, maximum length 10240 bytes,
                 -- and save its content into msg and its source
                 -- IP and port into addr
                 (msg, addr) <- recvFrom sock 10240
                 -- Handle it
                 handlerfunc addr msg
                 -- And process more messages
                 run' <- readMVar run
                 if run' then procMessages sock else return ()

-- A simple handler that prints incoming packets
plainHandler :: HandlerFunc
plainHandler addr msg =
    BC.putStrLn $ BC.append (UTF8.fromString $ "From " ++ show addr ++ ": ") msg

-- A simple handler that prints incoming packets
fileHandler :: FilePath -> FilePath -> HandlerFunc
fileHandler dir basefile addr msg = do
    date <- today >>= \x -> return (dayToDate x)
    let file = printf "%s-%04d-%02d-%02d.log" basefile (getYear $ dateYear date) (getMonth $ dateMonth date) (getDayOfMonth $ dateDay date)
    let file' = joinPath [dir, file]
    withFile file' AppendMode $ \ h -> BC.hPutStrLn h msg

