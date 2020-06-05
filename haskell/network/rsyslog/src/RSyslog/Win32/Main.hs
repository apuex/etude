module Main(main) where

import           RSyslog.CmdLine
import           RSyslog.UDPServer
import           System.Directory
import           System.Environment
import           System.FilePath
import           System.IO

main :: IO ()
main = do
    progName <- getProgName
    args     <- getArgs
    (opts, files) <- compileOpts progName args
    createDirectoryIfMissing True $ logDir opts
    if console opts then serveLog "514" plainHandler
    else serveLog "514" $ fileHandler (logDir opts) "rsyslog"

