{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}

module Messages where

import           Prelude.Compat (Bool, String, Float, Maybe(Just, Nothing), Eq, Show, IO)
import           Data.Aeson (FromJSON, ToJSON, decode, encode, Object)
import qualified Data.ByteString.Lazy.Char8 as BL
import           GHC.Generics (Generic)
import           GHC.Int

data SensorData = GreetingEvent {
        to :: String
        , message :: String
    }
--    | AI { id :: String, analogValue :: Maybe Float }
--    | DI { id :: String, digitalValue :: Maybe Bool }
--    | Alarm {id :: String, desc :: String }
    deriving (Eq, Show, Generic)

data EventEnvelope = EventEnvelope {
        offset :: String
        , persistenceId :: String
        , sequenceNr :: String
        , event :: Object
    }
    deriving (Eq, Show, Generic)

instance FromJSON SensorData
instance ToJSON   SensorData

instance FromJSON EventEnvelope
instance ToJSON   EventEnvelope

