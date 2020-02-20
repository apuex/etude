module Mylib.Base
    ( MyFoo
    , MyBar
    , version
    , setFoo
    , updateFoo
    , getBar
    , setBar
    , updateBar
    ) where

import           Mylib.Base.C
import           Mylib.Base.Types
import           Foreign.C.String
import           Foreign.Marshal.Utils (with)
import Text.Printf


version :: IO String
version = do
    v <- my_version >>= peekCString
    return v

setFoo :: MyFoo -> IO Int
setFoo foo = with foo $ \ p -> do
    result <- my_set_foo p
    return (fromIntegral result)

updateFoo :: MyFoo -> IO MyFoo
updateFoo foo = with foo $ \ p -> do
    result <- my_update_foo p >>= peekMyFoo
    return result

getBar :: IO MyBar
getBar = do
    bar <- my_get_bar >>= peekMyBar
    printf "[Base.hs]: %s\n" (barY bar)
    return bar

setBar :: MyBar -> (MyBar -> IO ()) -> IO Int
setBar bar f = with bar $ \ p -> do
    result <- my_set_bar p
    peekMyBar p >>= f
    return (fromIntegral result)

updateBar:: MyBar -> IO MyBar
updateBar bar = with bar $ \ p -> do
    result <- my_update_bar p >>= peekMyBar
    return result

