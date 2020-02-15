{-# LANGUAGE OverloadedStrings #-}
module Main (main) where

import qualified Control.Monad       as M
import           Control.Monad.Trans.Resource (MonadResource)
import qualified Data.ByteString as S
import qualified Data.List           as L
import           Data.Conduit
import           Data.Conduit.Binary
import qualified Data.Conduit.List   as CL
import           Data.CSV.Conduit
import qualified Data.Text           as T
import           Text.Printf
import           System.IO
import           System.Environment
import           System.FilePath
import           CmdLine


main :: IO ()
main = do
    progName <- getProgName
    args     <- getArgs
    (opts, files) <- compileOpts progName args
    if null files
        then hPutStrLn stderr (header progName)
        else M.mapM_ (transform opts) files

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
               --(sinkFile $ inputFile ++ ".expr")
               (case outputDir opts of
                    Just dir -> sinkFile $ joinPath [ dir, takeFileName inputFile ++ ".expr" ]
                    Nothing  -> sinkHandle stdout)
