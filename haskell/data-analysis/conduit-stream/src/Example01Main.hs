{-# LANGUAGE OverloadedStrings #-}
module Main (main) where

import qualified Data.List           as L
import           Data.Conduit
import           Data.Conduit.Binary
import qualified Data.Conduit.List   as CL
import           Data.CSV.Conduit
import qualified Data.Text           as T

-- Just reverse te columns
removeWithNulls :: Monad m => Conduit (Row T.Text) m (Row T.Text)
removeWithNulls = CL.filter $ L.foldl (&&) True . L.map (not .T.null)

stripColumns :: Monad m => Conduit (Row T.Text) m (Row T.Text)
stripColumns = CL.map (L.map T.strip)

dropFirstColumn :: Monad m => Conduit (Row T.Text) m (Row T.Text)
dropFirstColumn = CL.map L.tail

main :: IO ()
main = runResourceT $
  transformCSV defCSVSettings { csvQuoteChar = Nothing }
               (sourceFile "test/BigFile.csv")
               (stripColumns
               $= removeWithNulls
               $= dropFirstColumn
               )
               (sinkFile "test/BigFileOut.csv")
