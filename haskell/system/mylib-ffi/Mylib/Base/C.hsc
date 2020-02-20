{-# LANGUAGE ForeignFunctionInterface #-}
{-# LANGUAGE CPP                      #-}

module Mylib.Base.C where

import Mylib.Base.Types
import Foreign
import Foreign.C

import Control.Applicative
import Control.Monad

#include "mylib.h"

foreign import ccall "mylib.h my_version" my_version
    :: IO CString

foreign import ccall "mylib.h my_set_foo" my_set_foo
    :: Ptr MyFoo -> IO CInt

foreign import ccall "mylib.h my_update_foo" my_update_foo
    :: Ptr MyFoo -> IO (Ptr MyFoo)

foreign import ccall "mylib.h my_get_bar" my_get_bar
    :: IO (Ptr MyBar)

foreign import ccall "mylib.h my_set_bar" my_set_bar
    :: Ptr MyBar -> IO CInt

foreign import ccall "mylib.h my_update_bar" my_update_bar
    :: Ptr MyBar -> IO (Ptr MyBar)

