{-# LANGUAGE OverloadedStrings #-}
module CmdLine where

import           Text.Printf
import           System.Console.GetOpt
import           System.IO
import           System.Exit
import           System.Environment


data Options = Options
    { dropId     :: Bool
    , printHelp  :: Bool
    } deriving Show

defaultOptions = Options
    { dropId     = False
    , printHelp  = False
    }

options :: [OptDescr (Options -> Options)]
options =
    [ Option ['d']    ["drop-id"] (NoArg (\ opts -> opts { dropId = True })) "drop id column, which is the first column"
    , Option ['h']    ["help"] (NoArg (\ opts -> opts { printHelp = True })) "print this help message"]

compileOpts :: PrintfArg t => t -> [String] -> IO (Options, [String])
compileOpts progName argv = case getOpt Permute options argv of
    (o,n,[]  ) -> do
        let opts = foldl (flip id) defaultOptions o
        if printHelp opts
            then do hPutStr stderr (usageInfo (header progName) options)
                    exitSuccess
            else return (opts, n)
    (_,_,errs) -> ioError (userError (concat errs ++ usageInfo (header progName) options))

header :: PrintfArg t => t -> String
header progName = printf "Usage: %s [OPTION...] files..." progName

