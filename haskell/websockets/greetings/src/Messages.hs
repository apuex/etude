{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}

module Messages where

import           Data.HashMap.Strict (lookup, insert, fromList)
import           Data.Aeson --(FromJSON, ToJSON, decode, encode, Object, withObject)
import qualified Data.ByteString.Lazy.Char8 as BL
import           GHC.Generics (Generic)
import           GHC.Int

data GreetingEvent = GreetingEvent1 {
        to :: String
        , message :: String
    } | GreetingEvent2 {
        to1 :: String
        , message :: String
    }
    deriving (Eq, Show, Generic)

data EventEnvelope = EventEnvelope {
        offset :: String
        , persistenceId :: String
        , sequenceNr :: String
        , event :: Object
    }
    deriving (Eq, Show, Generic)

instance FromJSON GreetingEvent where
    parseJSON = withObject "greeting or event" $ \o -> do
        kind <- o .: "@type"
        case kind of
            "type.googleapis.com/com.example.leveldb.SayHelloEvent" ->
                GreetingEvent1 <$> o .: "to"
                               <*> o .: "message"

            "type.googleapis.com/com.example.leveldb.SayHelloEvent1" ->
                GreetingEvent2 <$> o .: "to1"
                               <*> o .: "message"

            _                                                       ->
                fail ("unknown kind: " ++ kind)

instance ToJSON   GreetingEvent where
    toJSON (GreetingEvent1 to message) = Object $
        fromList [
            "@type"   .= String "type.googleapis.com/com.example.leveldb.SayHelloEvent",
            "to"      .= to,
            "message" .= message
        ]
    toJSON (GreetingEvent2 to message) = Object $
        fromList [
            "@type"   .= String "type.googleapis.com/com.example.leveldb.SayHelloEvent1",
            "to"      .= to,
            "message" .= message
        ]


instance FromJSON EventEnvelope
instance ToJSON   EventEnvelope
