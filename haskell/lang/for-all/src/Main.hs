{-# LANGUAGE RankNTypes, LiberalTypeSynonyms #-}
{-# LANGUAGE ScopedTypeVariables #-}

module Main(main) where

import Text.Printf

main :: IO ()
main = do
  forall a. (printf) ["hello", "world"]

