{-# LANGUAGE DeriveDataTypeable, EmptyDataDecls, ForeignFunctionInterface #-}
{-# LANGUAGE RecordWildCards #-}

module Mylib.Base.Types where

import           Control.Applicative
import           Foreign
import           Foreign.C.Types
import           Foreign.C.String
import           Foreign.Ptr
import           Foreign.Storable

#include "mylib.h"

data MyFoo = MyFoo
    { fooX :: !Int
    , fooY :: !Double
    } deriving (Eq, Show)

data MyBar = MyBar
    { barX :: !Int
    , barY :: !String
    } deriving (Eq, Show)

data MyFooBar = Foo MyFoo | Bar MyBar deriving (Eq, Show)

data MyDataType
    = FOO_TYPE
    | BAR_TYPE
    deriving (Eq, Show)

instance Enum MyDataType where
    toEnum 0 = FOO_TYPE
    toEnum 1 = BAR_TYPE
    fromEnum FOO_TYPE = 0
    fromEnum BAR_TYPE = 0

data MyData = MyData
    { _type :: MyDataType
    , _data  :: MyFooBar
    } deriving (Eq, Show)

peekMyFoo :: Ptr MyFoo -> IO MyFoo
peekMyFoo ptr = do
    x <- #{peek my_foo_t, x} ptr
    y <- #{peek my_foo_t, y} ptr
    return (MyFoo x y)

pokeMyFoo :: Ptr MyFoo -> MyFoo -> IO ()
pokeMyFoo ptr MyFoo{..} = do
    #{poke my_foo_t, x} ptr fooX
    #{poke my_foo_t, y} ptr fooY

peekMyBar :: Ptr MyBar -> IO MyBar
peekMyBar ptr = do
    x <- #{peek my_bar_t, x} ptr
    y <- peekCString $ #{ptr my_bar_t, y} ptr
    return (MyBar x y)

pokeMyBar :: Ptr MyBar -> MyBar -> IO ()
pokeMyBar ptr MyBar{..} = do
    #{poke my_bar_t, x} ptr barX
    cY     <- newCString barY
    yValue <- peekArray (length barY) cY
    pokeArray (#{ptr my_bar_t, y} ptr) yValue

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

