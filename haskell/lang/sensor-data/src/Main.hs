data SensorData = AI String Float
  | DI String Bool
  | SI String String
  deriving (Eq, Show, Read)

main :: IO ()
main = do
  let ai = AI "CPU Temperature" 45.0
  let di = DI "CPU Overheat" False
  let si = SI "CPU Brand" "Intel"

  putStrLn "SensorData Serialized to String:"

  let aiStr = show ai
  let diStr = show di
  let siStr = show si

  putStrLn aiStr
  putStrLn diStr
  putStrLn siStr

  putStrLn "SensorData Parsed from String:"

  let ai' = read aiStr::SensorData
  let di' = read diStr::SensorData
  let si' = read siStr::SensorData

  putStrLn $ show ai'
  putStrLn $ show di'
  putStrLn $ show si'

