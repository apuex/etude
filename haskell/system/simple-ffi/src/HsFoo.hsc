{-# LANGUAGE ForeignFunctionInterface #-}
{-# LANGUAGE CPP                      #-}

module HsFoo where

import Foreign
import Foreign.C

import Control.Applicative
import Control.Monad

#include "foo.h"

toCInt :: Int -> CInt
toCInt i = fromIntegral i :: CInt

toInt :: IO CInt -> IO Int
toInt ioc = do
    c <- ioc
    return (fromIntegral c :: Int)

data Foo = Foo { 
    c :: Int
  , a :: CString
  , b :: CString
} deriving Show

instance Storable Foo where
    sizeOf    _ = #{size foo}
    alignment _ = #{alignment foo}
    -- alignment _ = alignment (undefined :: CString)

    poke = pokeFoo

    peek = peekFoo


peekFoo :: Ptr Foo -> IO Foo
peekFoo p = return Foo
    `ap` (toInt $ #{peek foo, c} p)
    `ap` (#{peek foo, a} p)
    `ap` (#{peek foo, b} p)

pokeFoo :: Ptr Foo -> Foo -> IO ()
pokeFoo p foo = do
        #{poke foo, c} p $ toCInt $ c foo
        #{poke foo, a} p $ a foo
        #{poke foo, b} p $ b foo

foreign import ccall "foo.h get_foo" get_foo :: IO (Ptr Foo)
foreign import ccall "foo.h cmain" cmain :: IO ()
foreign export ccall "free_HaskellPtr" free :: Ptr a -> IO ()
foreign export ccall "setFoo" setFoo :: Ptr Foo -> IO ()

getFoo :: IO Foo
getFoo = get_foo >>= peekFoo

setFoo :: Ptr Foo -> IO ()
setFoo f = do
  newA <- newCString "abc"
  newB <- newCString "def"
  poke f $ Foo 3 newA newB
  return ()
