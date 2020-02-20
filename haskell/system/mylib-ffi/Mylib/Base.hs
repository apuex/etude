module Mylib.Base
    ( MyFoo
    , MyBar
    , setFoo
    , updateFoo
    , getBar
    ) where

import Mylib.Base.C
import Mylib.Base.Types
import Foreign.Marshal.Utils (with)

setFoo :: MyFoo -> IO Int
setFoo foo = with foo $ \ p -> do
    result <- my_set_foo p
    return (fromIntegral result)

updateFoo :: MyFoo -> IO MyFoo
updateFoo foo = with foo $ \ p -> do
    result <- my_update_foo p >>= peekMyFoo
    return result

getBar :: MyBar -> IO Int
getBar bar = with bar $ \ p -> do
    result <- my_get_bar p
    return (fromIntegral result)
