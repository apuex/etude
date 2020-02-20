{-# LANGUAGE CPP, EmptyDataDecls, ForeignFunctionInterface #-}
module Mylib.Base.C where

#include "mylib.h"

import Data.ByteString (useAsCString)
import Mylib.Base.Types
import Foreign.C.Types
import Foreign.Marshal.Utils
import Foreign.Ptr


foreign import ccall unsafe "mylib.h my_set_foo" my_set_foo
    :: Ptr MyFoo -> IO CInt

foreign import ccall unsafe "mylib.h my_update_foo" my_update_foo
    :: Ptr MyFoo -> IO (Ptr MyFoo)

foreign import ccall unsafe "mylib.h my_get_bar" my_get_bar
    :: Ptr MyBar -> IO CInt

