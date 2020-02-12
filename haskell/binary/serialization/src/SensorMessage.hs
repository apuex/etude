module SensorMessage where

import qualified Data.ByteString.Lazy  as BL
import qualified Data.ByteString.Char8 as C
import           Data.Binary.Get
import           Data.Binary.Put
import           Data.Binary
import           Data.Word
import           Data.Maybe (fromMaybe)
import           Data.Time
import           Data.Time.Clock
import           Data.Time.Clock.POSIX
import           Data.Fixed

data SensorValue
    = AnalogValue  { _id :: C.ByteString, ts :: UTCTime, value :: Maybe Float }
    | DigitalValue { _id :: C.ByteString, ts :: UTCTime, state :: Maybe Bool  }
    | StringValue  { _id :: C.ByteString, ts :: UTCTime, text  :: Maybe C.ByteString  }
    | Event        { _id :: C.ByteString, ts :: UTCTime, priority :: Int, desc :: Maybe C.ByteString }
    deriving (Eq, Show)

data SensorRequest
    = GetValues    { ids    :: [C.ByteString]                           }
    | SetValues    {                            values :: [SensorValue] }
    | GetEvents    { ids    :: [C.ByteString],  after  :: UTCTime       }
    | GetAllEvents {                            after  :: UTCTime       }
    deriving (Eq, Show)

serializeSensorValue :: SensorValue -> Put
serializeSensorValue sv = do
    case sv of
        AnalogValue  _id ts value  -> do
            putWord8 0
            putByteString   _id
            putWord64be   $ fromIntegral $ posixSeconds ts
            putFloatbe    $ fromMaybe 0 value
        DigitalValue _id ts value   -> do
            putWord8 1
            putByteString   _id
            putWord64be   $ fromIntegral $ posixSeconds ts
        StringValue  id ts value   -> putWord8 2
        Event id ts priority value -> putWord8 8

posixSeconds :: UTCTime -> Int
posixSeconds ut = d
    where
        pt     = utcTimeToPOSIXSeconds ut
        d      = round pt

-- deserializeSensorValue :: Get(SensorValue)
-- deserializeSensorValue sv = do
