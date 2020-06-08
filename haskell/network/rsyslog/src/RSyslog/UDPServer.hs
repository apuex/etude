module RSyslog.UDPServer where

import           Chronos
import           Control.Concurrent      (forkIO)
import           Control.Monad.Trans     (liftIO)
import qualified RSyslog.CmdLine             as CL
import           Control.Concurrent.MVar
import           Data.Bits
import qualified Data.ByteString.Char8       as BC
import qualified Data.ByteString.UTF8        as UTF8
import           Data.List
import           GHC.IO.Handle
import           Network.Socket              hiding (recvFrom)
import           Network.Socket.ByteString
import           System.Directory
import           System.FilePath
import           System.IO
import           Text.Printf

type HandlerFunc = SockAddr -> BC.ByteString -> IO ()

data ServerState
    = ServerState
    { logDir    :: String
    , baseFile  :: String
    , date      :: MVar Date
    , handle    :: MVar Handle
    , terminate :: MVar Bool
    }

createServer :: CL.Options
           -> IO (ServerState)
createServer opts = do
    createDirectoryIfMissing True $ CL.logDir opts

    date' <- today >>= \x -> return (dayToDate x)
    startDate <- newMVar date'
    handle'   <- openLogFile (CL.logDir opts) (CL.baseFile opts) date' >>= newMVar
    stop      <- newMVar False
    let state = ServerState
            { logDir    = CL.logDir   opts
            , baseFile  = CL.baseFile opts
            , date      = startDate
            , handle    = handle'
            , terminate = stop
            }
    return state

startServe :: CL.Options
           -> ServerState
           -> IO ()
startServe opts state = do
    if CL.console opts then serveLog state (CL.host opts) (CL.port opts) plainHandler
    else serveLog state (CL.host opts) (CL.port opts) $ fileHandler state

serveLog :: ServerState
         -> String              -- ^ Host name or address
         -> String              -- ^ Port number or name; 514 is default
         -> HandlerFunc         -- ^ Function to handle incoming messages
         -> IO ()
serveLog state host port handlerfunc = withSocketsDo $
    do -- Look up the port.  Either raises an exception or returns
       -- a nonempty list.  
       addrinfos <- getAddrInfo 
                    (Just (defaultHints {addrFlags = [AI_PASSIVE]}))
                    (Just host) (Just port)
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
                 stop <- readMVar (terminate state)
                 if not stop then procMessages sock else return ()

-- A simple handler that prints incoming packets
plainHandler :: HandlerFunc
plainHandler addr msg =
    BC.putStrLn $ BC.append (UTF8.fromString $ "From " ++ show addr ++ ": ") msg

-- A simple handler that prints incoming packets
fileHandler :: ServerState -> HandlerFunc
fileHandler state addr msg = do
    h <- rotateLogFile state
    BC.hPutStrLn h msg

rotateLogFile:: ServerState -> IO (Handle)
rotateLogFile state = do
    d' <- readMVar (date state)
    d  <- today >>= \x -> return (dayToDate x)

    if (d /= d') then do
        modifyMVar_ (date state) $ \ _ -> return d

        let closeFile = do
                h <- readMVar (handle state)
                hClose h
        forkIO $ closeFile

        openLogFile (logDir state) (baseFile state) d
    else readMVar (handle state)

openLogFile :: FilePath -> FilePath -> Date -> IO (Handle)
openLogFile dir basefile date = do
    let file = printf "%s-%04d-%02d-%02d.log" basefile (getYear $ dateYear date) (getMonth $ dateMonth date) (getDayOfMonth $ dateDay date)
    let file' = joinPath [dir, file]

    h <- openFile file' AppendMode
    hSetBuffering h NoBuffering
    return h


