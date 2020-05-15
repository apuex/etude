{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}
-- {-# LANGUAGE NoImplicitPrelude #-}

module AI where

import Data.Aeson
import qualified Data.ByteString.Lazy.Char8 as BL
import GHC.Generics (Generic)

data AI = AI { id :: String, value :: Maybe Float } deriving (Eq, Show, Generic)

customOptions :: Options
customOptions = defaultOptions { omitNothingFields = True }

instance FromJSON AI where
     parseJSON = genericParseJSON customOptions
instance ToJSON   AI where
    toJSON     = genericToJSON customOptions
