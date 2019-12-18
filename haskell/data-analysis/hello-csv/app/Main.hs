module Main(main) where

import System.Console.GetOpt
import System.IO
import System.Exit
import System.Environment
import Data.List
import Data.Char
import Control.Monad
import Text.Printf
import Text.CSV

main = do
    (args, files) <- getArgs >>= parse
    mapM_ (\f -> withInputFile f doWork) files

withInputFile s f = do
  lines <- open s
  let csv = parseCSV s lines
  either handleError f csv
    where
      open f = if f == "-" then getContents else readFile f

handleError csv = putStrLn "error parsing"

-- tail just ignore the header line.
doWork csv = (print.findOldest.tail) csv

findOldest :: [Record] -> Record
findOldest [] = []
findOldest xs = foldl1
  (\a x -> if age x > age a then x else a) xs

age :: Record -> Int
age [] = 0
age [_,b] = toInt b 
age [_] = 0

toInt :: String -> Int
toInt s = read s::Int

data Flag
    = Help                  -- --help
    deriving (Eq,Ord,Enum,Show,Bounded)

flags =
   [Option ['h']    ["help"] (NoArg Help) "Print this help message"]

parse argv = case getOpt Permute flags argv of
    (args,fs,[]) -> do
        let files = if null fs then ["-"] else fs
        if Help `elem` args
            then do hPutStrLn stderr (usageInfo header flags)
                    exitWith ExitSuccess
            else return (nub (concatMap set args), files)

    (_,_,errs)      -> do
        hPutStrLn stderr (concat errs ++ usageInfo header flags)
        exitWith (ExitFailure 1)

    where header = "Usage: hello-csv [-h] [file ...]"

          set f      = [f]

