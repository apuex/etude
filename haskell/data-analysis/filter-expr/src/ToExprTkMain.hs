{-# LANGUAGE OverloadedStrings #-}
module Main (main) where

import qualified Control.Monad        as M
import qualified Data.List            as L
import qualified Data.Text.Lazy       as TL
import qualified Data.Text.Lazy.IO    as TLIO
import           Text.Regex
import           System.IO
import           System.Environment
import           System.FilePath
import           CmdLine
import           Tokenizer


main :: IO ()
main = do
    progName <- getProgName
    args     <- getArgs
    (opts, files) <- compileOpts progName args
    if null files
        then hPutStrLn stderr (header progName)
        else do
            content <- M.mapM (withInputFile transform opts) files
            M.mapM_ (toFile opts) content

withInputFile :: (Options -> TL.Text -> [TL.Text]) -> Options -> FilePath -> IO (FilePath, [TL.Text])
withInputFile f opts inputFile = do
    content <- TLIO.readFile inputFile
    return (inputFile, f opts content)

transform ::Options -> TL.Text -> [TL.Text]
transform opts content = L.map toExprTk
    $ TL.lines content

toFile :: Options -> (FilePath, [TL.Text]) -> IO ()
toFile opts (inputFile, exprs) = case outputDir opts of
    Just dir -> do
        output <- openBinaryFile (joinPath [ dir, takeFileName inputFile ++ ".tk"]) WriteMode
        M.mapM_ (TLIO.hPutStrLn output) exprs
    Nothing  -> M.mapM_ (TLIO.hPutStrLn stdout) exprs

