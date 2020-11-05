{-# LANGUAGE OverloadedStrings #-}
module Config where

import           Control.Monad
import           Data.Int
import           Data.Maybe
import qualified Data.Configurator       as C
import qualified Data.Configurator.Types as C
import qualified CmdLine                 as CL
import           System.Directory
import           System.Environment
import           System.FilePath
import           Text.Printf

extractConfig :: C.Config -> [ CL.Options -> IO CL.Options ]
extractConfig conf =
    [ \ opts -> do
        o <- C.lookup conf "working-dir" :: IO (Maybe String)
        return (opts { CL.workingDir = fromMaybe (CL.workingDir opts) o})
    , \ opts -> do
        o <- C.lookup conf "mq-broker.cluster" :: IO (Maybe [String])
        return (maybe opts (\ x -> opts { CL.mqBrokerCluster = x }) o)
    , \ opts -> do
        o <- C.lookup conf "broker.response-dest" :: IO (Maybe String)
        return (maybe opts (\ x -> opts { CL.mqRequestDest = x }) o)
    , \ opts -> do
        o <- C.lookup conf "mq-broker.request-dest" :: IO (Maybe String)
        return (maybe opts (\ x -> opts { CL.mqResponseDest = x }) o)
    ]

getHome :: CL.Options -> IO FilePath
getHome opts = do
    if (CL.workingDir opts == "") then do
        exe  <- getExecutablePath
        return (takeDirectory $ takeDirectory exe)
    else if (CL.workingDir opts == ".") then do
        getCurrentDirectory
    else return (CL.workingDir opts)

loadConfig :: CL.Options -> IO (CL.Options)
loadConfig opts = do
    home <- getHome opts
    let configFile = home </> (CL.configFile opts)
    loadedConf <- C.load [C.Required configFile]
    opts' <- foldM (\ o f -> f o) (opts { CL.workingDir = home }) $ extractConfig loadedConf
    return (opts' { CL.workingDir = home })

loadOpts :: PrintfArg t => t -> [String] -> CL.Options -> IO CL.Options
loadOpts progName args opts' = do
    -- get initial configure file option
    optsInit <- CL.compileOpts progName args CL.defaultOptions
    -- override with file configurations
    optsFile <- loadConfig optsInit
    -- override with commandline options
    CL.compileOpts progName args optsFile