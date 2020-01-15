module Main(main) where

import Control.Monad.IO.Class
import Data.Time

data SensorData = AI { sid :: String, ts :: UTCTime, value :: Maybe Float } 
  | DI { sid :: String, ts :: UTCTime, state :: Maybe Bool }
  | SI { sid :: String, ts :: UTCTime, text:: Maybe String}
  | AO { sid :: String, ts :: UTCTime, value :: Maybe Float } 
  | DO { sid :: String, ts :: UTCTime, state :: Maybe Bool }
  | SO { sid :: String, ts :: UTCTime, text:: Maybe String}
  deriving (Eq, Show, Read)

main :: IO ()
main = do
  time <- liftIO getCurrentTime

  let _ai = AI { sid = "CPU Utilization", ts = time, value = Just 2.1 }
  let _ai' = AI { sid = "CPU Utilization", ts = time, value = Nothing }
  let _di = DI { sid = "High CPU Temperature", ts = time, state = Just False }
  let _si = SI { sid = "Brand Name", ts = time, text = Just "Intel" }
  let _ao = AO { sid = "CPU Utilization High Threshold", ts = time, value = Just 2.1 }
  let _do = DO { sid = "High CPU Temperature High Threshold", ts = time, state = Just False }
  let _so = SO { sid = "Supplier Name", ts = time, text = Just "Amazon" }

  putStrLn $ show _ai
  putStrLn $ show _ai'
  putStrLn $ show _di
  putStrLn $ show _si
  putStrLn $ show _ao
  putStrLn $ show _do
  putStrLn $ show _so

