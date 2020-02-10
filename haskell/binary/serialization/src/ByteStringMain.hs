module Main (main) where

import qualified Data.ByteString as B

main :: IO ()
main = do
    contents <- B.getContents
    B.putStr contents

