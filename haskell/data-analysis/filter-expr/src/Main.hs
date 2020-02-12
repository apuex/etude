{-# LANGUAGE OverloadedStrings #-}
module Main (main) where

import qualified Control.Monad       as M
import qualified Data.List           as L
import           Data.Conduit
import           Data.Conduit.Binary
import qualified Data.Conduit.List   as CL
import           Data.CSV.Conduit
import qualified Data.Text           as T
import           Text.Printf
import           System.Console.GetOpt
import           System.IO
import           System.Exit
import           System.Environment


removeWithNulls :: Monad m => Conduit (Row T.Text) m (Row T.Text)
removeWithNulls = CL.filter $ L.foldl (&&) True .
    L.map (\ x -> not (T.null x || (x == "NULL")))

stripColumns :: Monad m => Conduit (Row T.Text) m (Row T.Text)
stripColumns = CL.map (L.map T.strip)

dropIdColumn :: Monad m => Options -> Conduit (Row T.Text) m (Row T.Text)
dropIdColumn opts = if dropId opts
        then CL.map L.tail
        else awaitForever yield

transform :: Options -> String -> IO ()
transform opts inputFile = runResourceT $
    transformCSV defCSVSettings { csvQuoteChar = Nothing }
               (sourceFile inputFile)
               (stripColumns
               $= removeWithNulls
               $= dropIdColumn opts
               )
               (sinkFile $ inputFile ++ ".out")

main = do
    progName <- getProgName
    args     <- getArgs
    (opts, files) <- compileOpts progName args
    if null files
        then hPutStrLn stderr (header progName)
        else M.mapM_ (transform opts) files

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

