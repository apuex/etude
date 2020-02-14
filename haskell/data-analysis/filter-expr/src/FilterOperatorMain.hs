{-# LANGUAGE OverloadedStrings #-}
module Main (main) where

import qualified Control.Monad        as M
import           Control.Monad.State
import           Control.Monad.Trans (liftIO)
import           Data.Char
import qualified Data.List            as L
import qualified Data.Text.Lazy       as TL
import qualified Data.Text.Lazy.IO    as TLIO
import qualified Data.ByteString.Lazy.Char8 as BL
import qualified Data.Set             as Set
import           GHC.IO (unIO)
import           Text.Printf
import           Text.Regex
import           System.IO
import           System.Environment
import           CmdLine


main :: IO ()
main = do
    progName <- getProgName
    args     <- getArgs
    (opts, files) <- compileOpts progName args
    if null files
        then hPutStrLn stderr (header progName)
        else do
            tokens <- M.mapM (withInputFile transform opts) files
            let (_, a) = token
                    $ TL.pack
                    $ show
                    $ Set.fromList
                    $ L.concat tokens
            TLIO.putStrLn $ TL.strip a

withInputFile :: (Options -> TL.Text -> [TL.Text]) -> Options -> String -> IO [TL.Text]
withInputFile f opts inputFile = do
    content <- TLIO.readFile inputFile
    return (f opts content)

transform ::Options -> TL.Text -> [TL.Text]
transform opts content = filter (\ t -> case matchRegex (mkRegex "[0-9]+") (TL.unpack t) of
    Just _ -> False
    _      -> True
    )
    $ L.concatMap (fst . tokenize)
    $ TL.lines content

chars :: Set.Set Char
chars = Set.fromList "\n ()+.0123456789<=>[]adenorst"

blankChars :: Set.Set Char
blankChars = Set.fromList "\n\r\t "

arithOpChars :: Set.Set Char
arithOpChars = Set.fromList "+-*/"

comparatorChars :: Set.Set Char
comparatorChars = Set.fromList "<=>"

getValueOpChars :: Set.Set Char
getValueOpChars = Set.fromList "[]"

numberStartChars :: Set.Set Char
numberStartChars = Set.fromList "0123456789"

numberChars :: Set.Set Char
numberChars = Set.insert '.' numberStartChars

symbolStartChars :: Set.Set Char
symbolStartChars = Set.fromList
    $ concat
    [ ['_']
    , ['A'..'Z']
    , ['a' .. 'z']
    ]

symbolChars :: Set.Set Char
symbolChars = Set.union symbolStartChars
    $ Set.fromList ['0'..'9']

data TokenType
    = UnDetermined
    | SymbolName
    | Number
    deriving (Eq, Show, Enum)

type TokenState = State TokenType

setTokenState :: TokenType -> TokenState ()
setTokenState = put

tokenState :: TokenState TokenType
tokenState = get

testState :: TokenState TokenType
testState = do
    setTokenState SymbolName
    tokenState

tokenize :: TL.Text -> ([TL.Text], TL.Text)
tokenize input
    | TL.null input = ([], TL.empty)
    |     otherwise = loop [] input
    where loop tokens remaining =
            let (t, i) = token remaining
            in if TL.null i then (tokens ++ [t], i)
                else loop (tokens ++ [t]) i

token :: TL.Text -> (TL.Text, TL.Text)
token input
    |       Set.member c blankChars = token tail
    | Set.member c numberStartChars = number (TL.singleton c) tail
    | Set.member c symbolStartChars = symbol (TL.singleton c) tail
    |     Set.member c arithOpChars = (TL.singleton c, tail)
    |  Set.member c comparatorChars = comparator (TL.singleton c) tail
    |  Set.member c getValueOpChars = (TL.singleton c, tail)
    |                     otherwise = (TL.singleton c, tail)
    where c = TL.head input
          tail         = TL.tail input

number :: TL.Text -> TL.Text -> (TL.Text, TL.Text)
number   o input
    |            TL.null input = (o, input)
    | Set.member c numberChars = number (TL.snoc o c) (TL.tail input)
    |                otherwise = (o, input)
    where c = TL.head input

symbol :: TL.Text -> TL.Text -> (TL.Text, TL.Text)
symbol   o input
    |            TL.null input = (o, input)
    | Set.member c symbolChars = symbol (TL.snoc o c) (TL.tail input)
    |                otherwise = (o, input)
    where c = TL.head input

comparator :: TL.Text -> TL.Text -> (TL.Text, TL.Text)
comparator o input
    |            TL.null input = (o, input)
    | Set.member c comparatorChars = comparator (TL.snoc o c) (TL.tail input)
    |                otherwise = (o, input)
    where c = TL.head input

