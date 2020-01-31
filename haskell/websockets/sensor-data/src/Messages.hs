{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}

module Messages where

import           Prelude.Compat (Bool, String, Float, Maybe(Just, Nothing), Eq, IO)
import           Data.Aeson (FromJSON, ToJSON, decode, encode, Object)
import qualified Data.ByteString.Lazy.Char8 as BL
import           GHC.Generics (Generic)
import           GHC.Int

data SensorData =
    AI { id :: String, analogValue :: Maybe Float }
    | DI { id :: String, digitalValue :: Maybe Bool }
    | Alarm {id :: String, desc :: String }
    deriving (Eq, Generic)

data GreetingEvent = GreetingEvent {
        to :: String
        , message :: String
    }
    deriving (Eq, Generic)

data EventEnvelope = EventEnvelope {
        offset :: String
        , persistenceId :: String
        , sequenceNr :: String
        , event :: Object
    }
    deriving (Eq, Generic)

instance FromJSON GreetingEvent where
instance ToJSON   GreetingEvent

instance FromJSON EventEnvelope
instance ToJSON   EventEnvelope

