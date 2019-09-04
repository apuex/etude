{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}

module DI where

--import Prelude.Compat
import Prelude.Compat (String, Bool, Maybe(Just, Nothing), Eq, IO)

import Data.Aeson (FromJSON, ToJSON, decode, encode)
import qualified Data.ByteString.Lazy.Char8 as BL
import GHC.Generics (Generic)

data DI = DI { id :: String, value :: Maybe Bool} deriving (Eq, Generic)

instance FromJSON DI
instance ToJSON   DI

