module Main(main) where

import           RSyslog.CmdLine
import           RSyslog.UDPServer
import           System.Environment
import           System.FilePath
import           System.IO

main :: IO ()
main = do
    progName <- getProgName
    args     <- getArgs
    (opts, files) <- compileOpts progName args

    startServe opts


