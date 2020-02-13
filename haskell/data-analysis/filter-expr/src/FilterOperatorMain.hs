{-# LANGUAGE OverloadedStrings #-}
module Main (main) where

import qualified Control.Monad        as M
import           Control.Monad.Trans (liftIO)
import           Data.Char
import qualified Data.List            as L
import qualified Data.Text.Lazy       as TL
import qualified Data.Text.Lazy.IO    as TLIO
import qualified Data.ByteString.Lazy.Char8 as BL
import qualified Data.Set             as Set
import           GHC.IO (unIO)
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
            tokens <- M.mapM (transform opts) files
            let charSet =
                    L.concat tokens
            print charSet

transform :: Options -> String -> IO ([TL.Text])
transform opts inputFile = return ["state"]
