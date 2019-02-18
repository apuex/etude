import Client (fibonacci)
import Data.Char 
import System.Environment (getArgs)

main :: IO ()
main = do
  args <- getArgs
  print(map (fibonacci . read::String->Integer) args)

