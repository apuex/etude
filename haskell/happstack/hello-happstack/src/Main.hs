module Main where

import Happstack.Server (nullConf, simpleHTTP, ok)

main :: IO ()
main = simpleHTTP nullConf $ ok "Hello, World!"

