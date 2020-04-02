{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}
module Main(main) where

import           Data.Binary
import           Data.Binary.Get
import           Data.Binary.Put
import           Data.Char (ord)
import           Data.Word (Word8)
import qualified Data.ByteString              as B
import qualified Data.ByteString.Char8        as BC
import qualified Data.ByteString.Lazy.UTF8    as UTF8
import qualified Data.ByteString.Lazy         as BL
import qualified Data.ByteString.Base16       as Base16
import           GHC.Generics (Generic)

data MyInt = MyInt Word32 deriving (Eq, Show, Generic)
data MyString = MyString BC.ByteString deriving (Eq, Show, Generic)
data MyData = MyData Word32 BC.ByteString deriving (Eq, Show, Generic)

instance Binary MyInt
instance Binary MyString where
    put (MyString s) = do
        putByteString s
    get = do
        s <- getByteString 256
        return (MyString s)

instance Binary MyData where
    put (MyData i s) = do
        putWord32le   i
        putByteString s
    get = do
        i <- getWord32le
        s <- getByteString 256
        return (MyData i s)

main :: IO ()
main = do
    --let myint = encode (MyInt 123456)
    --BC.putStrLn $ (BL.toStrict myint)
    --let mystring = encode (MyString (BC.pack "0123456"))
    --BC.putStrLn $ (BL.toStrict mystring)
    let b = encode (MyData 123456 "0123456")
    BC.putStrLn $ (BL.toStrict b)
    --let bytes = runPut (putStringUtf8 "0123456")
    --BL.putStrLn bytes
    
