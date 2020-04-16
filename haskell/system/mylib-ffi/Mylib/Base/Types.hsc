{-# LANGUAGE ForeignFunctionInterface #-}
{-# LANGUAGE CPP                      #-}

module Mylib.Base.Types where

import Foreign
import Foreign.C
import Foreign.C.Types

import Control.Applicative
import Control.Monad

#include "mylib.h"

-- see https://wiki.haskell.org/FFI_cook_book
#if __GLASGOW_HASKELL__ < 800
#let alignment t = "%lu", (unsigned long)offsetof(struct {char x__; t (y__); }, y__)
#endif

maxLen = #{const MAX_STR_LEN}

data MyFoo = MyFoo
    { fooX :: CInt
    , fooY :: CDouble
    } deriving Show

data MyBar = MyBar
    { barX :: CInt
    , barS :: String
    , barY :: CDouble
    } deriving Show

data MyFooBar = Foo MyFoo | Bar MyBar deriving Show

data MyDataType
    = FOO_TYPE
    | BAR_TYPE
    deriving (Eq, Show)

instance Enum MyDataType where
    toEnum 0 = FOO_TYPE
    toEnum 1 = BAR_TYPE
    fromEnum FOO_TYPE = 0
    fromEnum BAR_TYPE = 1

data MyData = MyData
    { _type :: MyDataType
    , _data  :: MyFooBar
    } deriving Show

peekMyFoo :: Ptr MyFoo -> IO MyFoo
peekMyFoo p = return MyFoo
    `ap` (#{peek my_foo_t, x} p)
    `ap` (#{peek my_foo_t, y} p)

pokeMyFoo :: Ptr MyFoo -> MyFoo -> IO ()
pokeMyFoo p foo = do
    #{poke my_foo_t, x} p $ fooX foo
    #{poke my_foo_t, y} p $ fooY foo

peekMyBar :: Ptr MyBar -> IO MyBar
peekMyBar p = do
     i <- #{peek my_bar_t, x} p
     s <- peekCString $ #{ptr my_bar_t, s} p
     d <- #{peek my_bar_t, y} p
     return (MyBar i s d)

pokeMyBar :: Ptr MyBar -> MyBar -> IO ()
pokeMyBar p bar = do
    #{poke my_bar_t, x} p $ barX bar
    withCStringLen (take maxLen (barS bar)) $ uncurry (copyArray $ #{ptr my_bar_t, s} p)
    #{poke my_bar_t, y} p $ barY bar

instance Storable MyFoo where
    sizeOf _    = #{size      my_foo_t}
    alignment _ = #{alignment my_foo_t}
    peek        = peekMyFoo
    poke        = pokeMyFoo

instance Storable MyBar where
    sizeOf _    = #{size      my_bar_t}
    alignment _ = #{alignment my_bar_t}
    peek        = peekMyBar
    poke        = pokeMyBar

-- instance Storable MyData where
--    sizeOf _    = #{size      my_data_t}
--    alignment _ = #{alignment my_data_t}
--    peek        = peekMyData
--    poke        = pokeMyData

