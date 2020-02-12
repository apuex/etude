module Main (main) where

import qualified Data.ByteString       as B
import qualified Data.ByteString.Lazy  as BL
import qualified Data.ByteString.Char8 as C
import           Data.Binary.Get
import           Data.Binary.Put
import           Data.Word
import           SensorMessage
import           Data.Time

listOfWord16 = do
    empty <- isEmpty
    if empty
        then return []
        else do v <- getWord16be
                rest <- listOfWord16
                return (v: rest)

main :: IO ()
main = do
    -- contents <- BL.getContents
    -- print $ runGet listOfWord16 contents
    ts <- getCurrentTime
    let ai = AnalogValue { _id = C.pack "1"
        , ts  = ts
        , value = Just 1.0
        }
    let bytes = runPut $ serializeSensorValue ai
    BL.putStrLn bytes

