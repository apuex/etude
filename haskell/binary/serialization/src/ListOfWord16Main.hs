module Main (main) where

import qualified Data.ByteString.Lazy as BL
import           Data.Binary.Get
import           Data.Word

listOfWord16 = do
    empty <- isEmpty
    if empty 
        then return []
        else do v <- getWord16be
                rest <- listOfWord16
                return (v: rest)

main :: IO ()
main = do
    contents <- BL.getContents
    print $ runGet listOfWord16 contents

