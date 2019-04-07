module Main where

import System.IO
import qualified Data.ByteString.Lazy as BL
import System.Environment

main :: IO ()
main = do
    args <- getArgs
    let infileName = args !! 0
        outfileName = args !! 1
    infile <- openBinaryFile infileName ReadMode
    outfile <- openBinaryFile outfileName WriteMode
    c <- BL.hGetContents infile
    BL.hPutStr outfile c
    hClose infile
    hClose outfile

    
