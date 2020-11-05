{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE OverloadedStrings #-}
module CmdLine where

import           Data.Int
import qualified Data.List.Split       as LS
import qualified Data.Text             as T
import qualified Data.Text.Lazy        as TL
import           Text.Shakespeare.Text
import           Text.Printf
import           System.Console.GetOpt
import           System.IO
import           System.Exit


data Options = Options
    { configFile            :: String
    , workingDir            :: String
    , mqBrokerCluster       :: [String]
    , mqRequestDest         :: String
    , mqResponseDest        :: String
    , printHelp             :: Bool
    } deriving Show

defaultOptions :: Options
defaultOptions = Options
    { configFile            = "conf/application.conf"
    , workingDir            = ""
    , mqBrokerCluster       = ["localhost:6572"]
    , mqRequestDest         = "GMCC_CINT_TCP_ENDPOINT_IN"
    , mqResponseDest        = "GMCC_CINT_TCP_ENDPOINT_OUT"
    , printHelp             = False
    }

options :: [OptDescr (Options -> Options)]
options =
    [ Option []    ["config-file"]           (ReqArg (\ o opts -> opts { configFile         = o    }) "FILE"            ) "configuration file to override build-in default"
    , Option []    ["working-dir"]           (ReqArg (\ o opts -> opts { workingDir         = o    }) "DIR"             ) "working directory"
    , Option []    ["mq-broker-cluster"]     (ReqArg (\ o opts -> opts { mqBrokerCluster    = toList o }) "[HOST:PORT]" ) "MQ cluster address"
    , Option []    ["mq-request-dest"]       (ReqArg (\ o opts -> opts { mqRequestDest      = o    }) "QUEUE/TOPIC"     ) "MQ destination to publish"
    , Option []    ["mq-response-dest"]      (ReqArg (\ o opts -> opts { mqResponseDest     = o    }) "QUEUE/TOPIC"     ) "MQ destination to consume"
    , Option ['h'] ["help"]                  (NoArg  (\   opts -> opts { printHelp          = True })                   ) "print this help message"]

compileOpts :: PrintfArg t => t -> [String] -> Options -> IO Options
compileOpts progName argv opts' = do
    opts <- case getOpt Permute options argv of
        (o,n,[]  ) -> do
            let opts = foldl (flip id) (opts') o
            if printHelp opts
                then do hPutStr stderr (usageInfo (header progName) options)
                        exitSuccess
                else return (opts)
        (_,_,errs) -> ioError (userError (concat errs ++ usageInfo (header progName) options))
    return opts

header :: PrintfArg t => t -> String
header progName = printf "Usage: %s [OPTION...]" progName

toList :: String -> [String]
toList s = map (T.unpack . T.strip . T.pack) $ LS.splitOn "," s

formatOptions :: Options -> TL.Text
formatOptions opts = [lt|Current options are:
  --config-file           = '#{configFile                 opts}'
  --working-dir           = '#{workingDir                 opts}'
  --mq-broker-cluster     = '#{show $ mqBrokerCluster     opts}'
  --mq-request-dest       = '#{mqRequestDest              opts}'
  --mq-response-dest      = '#{mqResponseDest             opts}'
  --help                  = '#{show $ printHelp           opts}'
|]

