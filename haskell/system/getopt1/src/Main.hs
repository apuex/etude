module Main(main) where

import System.Console.GetOpt
import System.IO
import System.Exit
import System.Environment
import Data.List
import Data.Char
import Data.Maybe(fromMaybe)
import Control.Monad
import Text.Printf

data Flag
  = Version
  | Help
  | InputFile String
  | OutputDir String
  deriving (Eq, Ord, Show)

options :: [OptDescr Flag]
options = 
  [ Option ['v'] ["version"] (NoArg Version) "print version number"
  , Option ['h'] ["help"] (NoArg Help) "print help information"
  , Option ['f'] ["input-file"] (ReqArg InputFile "FILE") "specify input file"
  , Option ['d'] ["output-dir"] (OptArg (OutputDir .fromMaybe "") "DIR") "specify output directory"
  ]

outputDir :: Maybe String -> Flag
outputDir = OutputDir . fromMaybe ""

parse argv = case getOpt Permute options argv of

  (args, fs, []) -> do
    let files = if null fs then ["-"] else fs
    if Help `elem` args
      then do hPutStrLn stderr (usageInfo header options)
              exitWith ExitSuccess
      else return (nub (concatMap set args), files)

  (_, _, errs) -> do
    hPutStrLn stderr ( concat errs ++ usageInfo header options)
    exitWith (ExitFailure 1)

  where header = "Usage: getopt1 [-fhov] [file ...]"
        set Help = [Help, Version]    
        set f    = [f]

main :: IO ()
main = do
  (args, files) <- getArgs >>= parse
  
  putStrLn $ show args
  putStrLn $ show files 

