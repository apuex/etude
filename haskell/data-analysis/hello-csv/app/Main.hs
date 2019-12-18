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
    when (Unbuffered `elem` args) $ hSetBuffering stdout NoBuffering
    mapM_ (\f -> withInputFile f doWork) files

withInputFile s f = do
  lines <- open s
  let csv = parseCSV "" lines
  either handleError f csv
    where
      open f = if f == "-" then getContents else readFile f

handleError csv = putStrLn "error parsing"

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
    = Blanks                -- -b
    | Dollar                -- -e 
    | Squeeze               -- -s
    | Tabs                  -- -t
    | Unbuffered            -- -u
    | Invisible             -- -v
    | Number                -- -n
    | Help                  -- --help
    deriving (Eq,Ord,Enum,Show,Bounded)

flags =
   [Option ['b'] ["ignore-blanks"]       (NoArg Blanks)
        "Implies the -n option but doesn't count blank lines."
   ,Option ['e'] ["end-of-line"]       (NoArg Dollar)
        "Implies the -v option and also prints a dollar sign (`$') at the end of each line."
   ,Option ['n'] ["line-number"]       (NoArg Number)
        "Number the output lines, starting at 1."
   ,Option ['s'] ["squeeze-blanks"]       (NoArg Squeeze)
        "Squeeze multiple adjacent empty lines, causing the output to be single spaced."
   ,Option ['t'] ["display-tabs"]       (NoArg Tabs)
        "Implies the -v option and also prints tab characters as `^I'."
   ,Option ['u'] ["unbuffered"]       (NoArg Unbuffered)
        "The output is guaranteed to be unbuffered (see setbuf(3))."
   ,Option ['v'] ["display-invisible"]       (NoArg Invisible)
        "Displays non-printing characters so they are visible."
   ,Option ['h']    ["help"] (NoArg Help)
        "Print this help message"
   ]

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

    where header = "Usage: cat [-benstuv] [file ...]"

          set Dollar = [Dollar, Invisible]
          set Tabs   = [Tabs,   Invisible]
          set f      = [f]

