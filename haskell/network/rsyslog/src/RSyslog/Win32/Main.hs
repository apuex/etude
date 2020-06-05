module Main(main) where

import           GHC.IO.Encoding (getLocaleEncoding, setLocaleEncoding, mkTextEncoding, utf8)
import           RSyslog.UDPServer
import           System.Win32.Console


main :: IO ()
main = do
    getLocaleEncoding >>= print
    setLocaleEncoding utf8
    setConsoleOutputCP 65001  
    getLocaleEncoding >>= print
    serveLog "514" plainHandler

