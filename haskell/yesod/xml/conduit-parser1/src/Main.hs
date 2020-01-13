{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes #-}
module Main(main) where

import qualified Data.Map        as M
import           Prelude         hiding (readFile, writeFile)
import           Text.Hamlet.XML 
import           Text.XML 
import           Text.Printf

main :: IO ()
main = do
  Document prologue root epilogue <- readFile def "input.xml"
  putStrLn $ transform root


transform :: Element -> String 
transform (Element name attrs children) = (printf "%s\n" $ nameLocalName name) ++
  concatMap (\x -> case x of
    (NodeElement e) -> transform e 
    _               -> "") children


