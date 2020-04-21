{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}
module DataObject where

import qualified AI as AI
import qualified DI as DI

import           Data.Aeson
import           Data.Aeson.Types
import           Data.HashMap.Strict (lookup, insert, fromList, toList)
import qualified Data.ByteString.Lazy.Char8 as BL
import           GHC.Generics (Generic)
import           GHC.Int

data DataObject
    = AIObject AI.AI
    | DIObject DI.DI
    deriving(Eq, Show, Generic)

instance ToJSON DataObject where
    toJSON (AIObject ai) = case (toJSON ai) of
        Object o -> Object $ insert "@type" "type.googleapis.com/AIObject" o
    toJSON (DIObject di) = case (toJSON di) of
        Object o -> Object $ insert "@type" "type.googleapis.com/DIObject" o
    --toJSON (AIObject ai) = Object $
    --    fromList [
    --        "@type" .= String "type.googleapis.com/AIObject",
    --        "value" .= ai
    --    ]
        --_        -> fail ("unknown object")

instance FromJSON DataObject where
    parseJSON v = p v 
        where p = withObject "DataObject" $ \ o -> do
                kind <- o .: "@type"
                case kind of
                    "type.googleapis.com/AIObject" -> 
                        fmap (\ ai -> AIObject ai) (parseJSON (Object o) :: Parser AI.AI)

                    "type.googleapis.com/DIObject" ->
                        fmap (\ di -> DIObject di) (parseJSON (Object o) :: Parser DI.DI)
                        --DIObject <$> o .: "value"

                    _                              ->
                        fail ("unknown kind: " ++ kind)
