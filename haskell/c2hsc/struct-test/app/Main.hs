module Main where

import Data.Char
import StructTest.Base.StructTest
import Foreign.Marshal.Utils

main :: IO ()
main = do
  let st = C'struct_test
         { c'struct_test'id = 1
         , c'struct_test'name = map (fromIntegral . ord) "Hello"
         }
  with st $ \ pst -> do
          c'print_struct_test pst

