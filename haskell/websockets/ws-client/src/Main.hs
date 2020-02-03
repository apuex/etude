{-# LANGUAGE OverloadedStrings #-}
module Main
    ( main
    ) where

import           System.Console.GetOpt
import           System.IO
import           System.Exit
import           System.Environment
import           Data.List
import           Text.Printf
import qualified Control.Exception   as E
import           Control.Concurrent  (forkIO)
import           Control.Monad       (forever, unless)
import           Control.Monad.Trans (liftIO)
import           Network.Socket      (withSocketsDo)
import           Data.Text           (Text)
import           Data.HashMap.Strict (delete)
import qualified Data.Text           as T
import qualified Data.Text.IO        as T
import qualified Network.WebSockets  as WS
import qualified Data.ByteString.Lazy.Char8 as BL

app :: WS.ClientApp ()
app conn = do
    putStrLn "Connected!"

    _ <- forkIO $ forever $ do
            line <- T.getLine
            unless (T.null line) $ WS.sendTextData conn line

    let loop = do
            msg <- E.try (WS.receiveData conn) :: IO (Either E.IOException BL.ByteString)
            case msg of
                Left  e -> do
                    liftIO $ putStrLn $ show e
                    exitFailure
                Right m -> liftIO $ BL.putStrLn m
            loop

    WS.withPingThread conn 30 (return ()) loop

    WS.sendClose conn ("Bye!" :: Text)

main :: IO ()
main = do
    progName <- getProgName
    args     <- getArgs
    (opts, files) <- compileOpts progName args
    printf "Connect with\n\tHOST\t= %s,\n\tPORT\t= %d,\n\t_URI\t= %s\n"
            (hostName opts)
            (portNumber opts)
            (requestUri opts)

    withSocketsDo $ WS.runClient
            (hostName opts)
            (portNumber opts)
            (requestUri opts)
            app

data Options = Options
    { hostName   :: String
    , portNumber :: Int
    , requestUri :: String
    , printHelp  :: Bool
    } deriving Show

defaultOptions = Options
    { hostName   = "concerto"
    , portNumber = 8000
    , requestUri = "/api/events"
    , printHelp  = False
    }

options :: [OptDescr (Options -> Options)]
options =
   [Option ['H']    ["host-name"] (ReqArg (\ h opts -> opts { hostName = h }) "HOST") "host name or ip address"
   , Option ['p']    ["port-number"] (ReqArg (\ p opts -> opts { portNumber = read p::Int }) "PORT") "port number"
   , Option ['u']    ["request-uri"] (ReqArg (\ r opts -> opts { requestUri = r }) "URI") "request uri"
   , Option ['h']    ["help"] (NoArg (\ opts -> opts { printHelp = True })) "Print this help message"]

compileOpts :: PrintfArg t => t -> [String] -> IO (Options, [String])
compileOpts progName argv = case getOpt Permute options argv of
    (o,n,[]  ) -> do
        let opts = foldl (flip id) defaultOptions o
        if printHelp opts
            then do hPutStrLn stderr (usageInfo header options)
                    exitSuccess
            else return (opts, n)
    (_,_,errs) -> ioError (userError (concat errs ++ usageInfo header options))
    where header = printf "Usage: %s [OPTION...] files..." progName


