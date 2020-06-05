module Main(main) where

import           RSyslog.UDPServer
import           GHC.IO.Encoding (getLocaleEncoding, setLocaleEncoding, mkTextEncoding, utf8)


main :: IO ()
main = do
    getLocaleEncoding >>= print
    serveLog "514" plainHandler

