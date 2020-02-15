{-# LANGUAGE OverloadedStrings #-}
module Tokenizer where

import qualified Data.List            as L
import qualified Data.Text.Lazy       as TL
import qualified Data.Text.Lazy.IO    as TLIO
import qualified Data.Set             as Set
import           Text.Printf
import           CmdLine


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
    |       Set.member c blankChars = blank (TL.singleton c) tail
    | Set.member c numberStartChars = number (TL.singleton c) tail
    | Set.member c symbolStartChars = symbol (TL.singleton c) tail
    |     Set.member c arithOpChars = (TL.singleton c, tail)
    |  Set.member c comparatorChars = comparator (TL.singleton c) tail
    |  Set.member c getValueOpChars = (TL.singleton c, tail)
    |                     otherwise = (TL.singleton c, tail)
--  |                     otherwise = error (printf "unknow charactor: %c" c)
    where c    = TL.head input
          tail = TL.tail input

blank :: TL.Text -> TL.Text -> (TL.Text, TL.Text)
blank   o input
    |            TL.null input = (o, input)
    |  Set.member c blankChars = blank (TL.snoc o c) (TL.tail input)
    |                otherwise = (o, input)
    where c = TL.head input

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
    |            TL.null input     = (o, input)
    | Set.member c comparatorChars = comparator (TL.snoc o c) (TL.tail input)
    |                otherwise     = (o, input)
    where c = TL.head input

toGetSignal :: TL.Text -> TL.Text
toGetSignal t = case t of
    "[" -> "get_signal("
    "]" -> ")"
    x   -> x

toExprTk ::TL.Text -> TL.Text
toExprTk = TL.concat . L.map toGetSignal . fst . tokenize

