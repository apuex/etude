{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}

module AI where

--import Prelude.Compat
import Prelude.Compat (String, Float, Maybe(Just, Nothing), Eq, IO)

import Data.Aeson (FromJSON, ToJSON, decode, encode)
import qualified Data.ByteString.Lazy.Char8 as BL
import GHC.Generics (Generic)

data AI = AI { id :: String, value :: Maybe Float } deriving (Eq, Generic)

instance FromJSON AI
instance ToJSON   AI

