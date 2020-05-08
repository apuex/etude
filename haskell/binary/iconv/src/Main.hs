{-# LANGUAGE OverloadedStrings #-}
module Main where

import qualified Codec.Text.IConv             as IConv
import qualified Data.ByteString.Char8        as BC
import qualified Data.ByteString.Lazy.UTF8    as UTF8
import qualified Data.ByteString.Lazy.Char8   as BL
import qualified Data.ByteString.Base16       as Base16

main :: IO ()
main = do
    let input = "1你好0" :: String
    let bs = UTF8.fromString input
    BL.putStrLn bs
    BC.putStrLn $ Base16.encode $ BL.toStrict   bs 
    BC.putStrLn $ Base16.encode $ BL.toStrict $ IConv.convert "UTF-8" "GBK" bs
    -- let output = IConv.convert "" "" ByteString.pack input
