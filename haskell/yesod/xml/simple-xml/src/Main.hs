{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes #-}
module Main(main) where

import qualified Data.Map                    as M
import           Prelude         hiding (readFile, writeFile)
import           Data.Text (Text)
import qualified Data.Text.Lazy.IO            as TL
import           Text.Hamlet.XML
import           Text.XML
import qualified Text.XML.Stream.Render       as R

main :: IO ()
main = do
    let prologue = Prologue [] Nothing []
    let li = myElement (myname "bill") (M.fromList [ ("family-name", "gates") ]) []
    let root = myElement (myname "microsoft") M.empty [NodeElement li]
    let document = Document prologue root []
    let rs = def { rsPretty = True }
    let text = renderText rs document
    TL.putStr text

myname :: Text -> Name
myname name = Name name (Just "http://www.microsoft.com") (Just "ns1")

myElement name attrs children = Element name attrs children

