module Main (main) where

import qualified Data.ByteString.Lazy as BL
import           Data.Binary.Get
import           Data.Word

deserializeHeader :: Get (Word32, Word32, Word32)
deserializeHeader = do
    alen   <- getWord32be
    plen   <- getWord32be
    chksum <- getWord32be
    return (alen, plen, chksum)

main :: IO ()
main = do
    input <- BL.getContents
    print $ runGet deserializeHeader input

