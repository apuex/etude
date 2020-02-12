{-# LANGUAGE OverloadedStrings #-}
module Main (main) where

import Data.Conduit
import Data.Conduit.Binary
import Data.CSV.Conduit
import Data.Text (Text)

myProcessor :: Monad m => Conduit (Row Text) m (Row Text)
myProcessor = awaitForever $ yield

-- Let's simply stream from a file, parse the CSV, reserialize it
-- and push back into another file.
main :: IO ()
main = runResourceT $ 
  sourceFile "test/BigFile.csv" $= 
  intoCSV defCSVSettings $=
  myProcessor $=
  fromCSV defCSVSettings $$
  sinkFile "test/BigFileOut.csv"
