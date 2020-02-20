module Main where

import HsFoo
import Foreign.C.String

main :: IO ()
main = do
  getFoo >>= \ foo -> do
    peekCString (a foo) >>= print
    peekCString (b foo) >>= print
    print $ c foo
  cmain
