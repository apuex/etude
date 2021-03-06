{-# LANGUAGE OverloadedStrings #-}
module Main(main) where

import System.Console.GetOpt
import System.IO
import System.Exit
import System.Environment
import Data.List
import Data.Char
import Data.Maybe
import qualified Data.Text as T
import Control.Monad
import Text.Printf
import Text.CSV

main = do
    (args, files) <- getArgs >>= parse
    mapM_ (\f -> withInputFile f $ doWork args) files

withInputFile s f = do
  lines <- open s
  let csv = parseCSV s lines
  either handleError f csv
    where
      open f = if f == "-" then getContents else readFile f

handleError csv = putStrLn "error parsing"

-- tail just ignore the header line.
doWork args = printf . wrapMap . formatOutput . putAll . if SkipHeader `elem` args then tail else id

formatOutput :: [String] -> String
formatOutput [] = ""
formatOutput [s] = s
formatOutput list = foldl (\r x -> r ++ ",\n  " ++ x) ("  " ++ head list) (tail list)

wrapMap :: String -> String
wrapMap s = "Map(\n" ++ s ++ "\n)"

putSingle :: Record -> Maybe String
putSingle [] = Nothing
putSingle [k, v] = Just (printf "\"%s\" -> \"%s\"" (strip k) (strip v))
putSingle _ = Nothing

strip  = T.unpack . T.strip . T.pack
lstrip = T.stripStart
rstrip = T.stripEnd

putAll :: [Record] -> [String]
putAll list = map (fromMaybe "") $ filter (\x -> case x of
    Nothing -> False
    _ -> True) $ map putSingle list

data Flag
    = Help                  -- --help
    | SkipHeader            -- --skip header line
    deriving (Eq,Ord,Enum,Show,Bounded)

flags =
   [Option ['s']    ["skip-header"] (NoArg SkipHeader) "Skip header line"
   , Option ['h']    ["help"] (NoArg Help) "Print this help message"]

parse argv = case getOpt Permute flags argv of
    (args,fs,[]) -> do
        let files = if null fs then ["-"] else fs
        if Help `elem` args
            then do hPutStrLn stderr (usageInfo header flags)
                    exitSuccess
            else return (nub (concatMap set args), files)

    (_,_,errs)      -> do
        hPutStrLn stderr (concat errs ++ usageInfo header flags)
        exitWith (ExitFailure 1)

    where header = "Usage: hello-csv [-h] [file ...]"

          set f      = [f]

