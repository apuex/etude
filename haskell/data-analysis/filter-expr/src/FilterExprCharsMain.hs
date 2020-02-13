{-# LANGUAGE OverloadedStrings #-}
module Main (main) where

import qualified Control.Monad        as M
import           Data.Char
import qualified Data.List            as L
import qualified Data.Text.Lazy       as TL
import qualified Data.Text.Lazy.IO    as TLIO
import qualified Data.ByteString.Lazy.Char8 as BL
import qualified Data.Set             as Set
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
        else do
            chars <- M.mapM (transform opts) files
            let charSet =
                    L.init $
                    L.tail $
                    show $
                    Set.toList $
                    Set.unions chars
            putStrLn charSet

transform :: Options -> String -> IO (Set.Set Char)
transform opts inputFile = do
    content <- TLIO.readFile inputFile
    let chars = TL.foldl (flip Set.insert) Set.empty content
    return chars
