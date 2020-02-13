{-# LANGUAGE OverloadedStrings #-}
module Main (main) where

import qualified Control.Monad        as M
import qualified Data.List            as L
import qualified Data.Text.Lazy       as TL
import qualified Data.Text.Lazy.IO    as TL
import           Text.Printf
import           System.IO
import           System.Environment
import           CmdLine


main :: IO ()
main = do
    progName <- getProgName
    args     <- getArgs
    (opts, files) <- compileOpts progName args
    if null files
        then hPutStrLn stderr (header progName)
        else M.mapM_ (transform opts) files

transform :: Options -> String -> IO ()
transform opts inputFile = do
    content <- TL.readFile inputFile
    M.mapM_ TL.putStrLn $ TL.lines content
