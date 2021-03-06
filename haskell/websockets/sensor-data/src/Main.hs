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
import           Data.Aeson          (FromJSON, ToJSON, decode, encode)
import           Messages

app :: WS.ClientApp ()
app conn = do
    putStrLn "Connected!"

    let loop = do
            msg <- WS.receiveData conn
            let o = decode msg :: Maybe EventEnvelope
            case o of
                Just d ->
                    liftIO $ BL.putStrLn $ case e' of
                        Just a -> toString e' -- encode e'
                        Nothing -> BL.concat [BL.pack "Unparsable event: ", s]
                        where
                            e   = event d
                            s   = encode e
                            e'  = decode s :: Maybe GreetingEvent
                Nothing ->
                    liftIO $ putStrLn "Unparsable."
                    -- return ()

            loop

    WS.withPingThread conn 30 (return ()) loop

    WS.sendClose conn ("Bye!" :: Text)

toString :: Maybe GreetingEvent -> BL.ByteString
toString e = case e of
    Just (GreetingEvent1 to message) -> BL.pack to
    Just (GreetingEvent2 to1 message) -> BL.pack to1
    x -> BL.pack ("unknown event: " ++ show x)

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


