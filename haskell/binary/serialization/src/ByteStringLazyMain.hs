module Main (main) where

import qualified Data.ByteString.Lazy as BL

main :: IO ()
main = do
    contents <- BL.getContents
    BL.putStr contents

