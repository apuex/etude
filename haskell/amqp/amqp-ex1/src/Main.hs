{-# LANGUAGE OverloadedStrings #-}
module Main (main) where

import           CmdLine
import           Config
import           Control.Concurrent                      (forkIO)
import           Control.Monad.Trans                     (liftIO)
import qualified Data.Text.Lazy                       as TL
import           Network.AMQP
import qualified Data.ByteString.Lazy.Char8           as BL
import           System.Environment
import           Text.Printf


main :: IO ()
main = do
    progName <- getProgName
    args     <- getArgs
    opts     <- loadOpts progName args defaultOptions

    putStrLn $ TL.unpack $ formatOptions opts
