{-# LANGUAGE QuasiQuotes, OverloadedStrings #-}
module Main(main) where

import           Text.Shakespeare.Text
import qualified Data.Text.Lazy.IO as TLIO
import           Data.Text (Text)
import           Control.Monad (forM_)

data Item = Item
  { itemName :: Text
  , itemQty  :: Int
  }

items :: [Item]
items =
  [ Item "apples" 5
  , Item "oranges" 10
  , Item "bananas" 8
  ]

main :: IO ()
main = forM_ items $ \item ->
  TLIO.putStrLn [lt|You have #{show $ itemQty item} #{itemName item}.
more, or less?|]
