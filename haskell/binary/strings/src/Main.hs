{-# LANGUAGE OverloadedStrings #-}

module Main where

import qualified Data.Text             as T
import qualified Data.Text.Encoding    as T
import qualified Data.Text.IO          as T
import qualified Data.ByteString.Char8 as C

inputEnglish:: T.Text
inputEnglish = "Hello!"

inputChinese :: T.Text
inputChinese = "你好！"

main :: IO ()
main = do
  T.putStrLn "Original inputs:"
  T.putStrLn $ inputEnglish
  T.putStrLn $ inputChinese

  T.putStrLn "Encode to utf8 and unpack to char8, and then print as String:"
  putStrLn $ C.unpack $ T.encodeUtf8 inputEnglish
  putStrLn $ C.unpack $ T.encodeUtf8 inputChinese

  T.putStrLn "Encode to utf8 and unpack to char8, and then print as char8:"
  C.putStrLn $ T.encodeUtf8 inputEnglish
  C.putStrLn $ T.encodeUtf8 inputChinese


