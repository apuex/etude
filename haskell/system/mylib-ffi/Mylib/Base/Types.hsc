{-# LANGUAGE ForeignFunctionInterface #-}
{-# LANGUAGE CPP                      #-}

module Mylib.Base.Types where

import Foreign
import Foreign.C
import Foreign.C.Types

import Control.Applicative
import Control.Monad

#include "mylib.h"

#if __GLASGOW_HASKELL__ < 800
#let alignment t = "%lu", (unsigned long)offsetof(struct {char x__; t (y__); }, y__)
#endif

data MyFoo = MyFoo
    { fooX :: CInt
    , fooY :: Double
    } deriving Show

data MyBar = MyBar
    { barX :: CInt
    , barY :: String
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
     s <- peekCString $ #{ptr my_bar_t, y} p
     return (MyBar i s)

pokeMyBar :: Ptr MyBar -> MyBar -> IO ()
pokeMyBar p bar = do
    #{poke my_bar_t, x} p $ barX bar
    withCStringLen (take maxLen (barY bar)) $ uncurry (copyArray $ #{ptr my_bar_t, y} p)
    where maxLen = #{const MAX_STR_LEN}

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

