{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}

module Main(main) where

import Prelude.Compat (print, String, Float, Maybe(Just, Nothing), Eq, IO)

import Data.Aeson (FromJSON, ToJSON, decode, encode)
import qualified Data.ByteString.Lazy.Char8 as BL
import qualified AI                         as AIV
import qualified DI                         as DIV
import qualified DataObject                 as D
import GHC.Generics (Generic)

data SensorData = AI AIV.AI | DI DIV.DI 
  deriving (Eq, Generic)

instance FromJSON SensorData
instance ToJSON   SensorData

main :: IO ()
main = do
  let ai = AIV.AI { AIV.id = "CPU Temp", AIV.value = Just 36.8 }
  let aiNothing = AIV.AI { AIV.id = "CPU Temp", AIV.value = Nothing }
  let aiJson = encode ai
  let aiNothingJson = encode aiNothing
  let ai' = decode aiJson :: Maybe AIV.AI
  let aiNothing' = decode aiNothingJson :: Maybe AIV.AI
  let aiObj = D.AIObject ai
  let aiObjJson = encode aiObj
  let aiObj' = decode aiObjJson :: Maybe D.DataObject
  BL.putStrLn aiJson
  BL.putStrLn aiNothingJson
  BL.putStrLn (encode ai')
  BL.putStrLn (encode aiNothing')
  BL.putStrLn (encode (AI ai))
  BL.putStrLn (aiObjJson)
  BL.putStrLn (encode aiObj')
  print (aiObj')
  BL.putStrLn (encode aiObj')

