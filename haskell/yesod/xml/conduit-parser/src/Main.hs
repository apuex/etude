{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes #-}
module Main(main) where

import qualified Data.Map        as M
import           Prelude         hiding (readFile, writeFile)
import           Text.Hamlet.XML
import           Text.XML

main :: IO ()
main = do
  Document prologue root epilogue <- readFile def "input.xml"
  let root' = transform root
  writeFile def
    { rsPretty = True
    } "output.html" $ Document prologue root' epilogue

transform :: Element -> Element
transform (Element _name attrs children) = Element "html" M.empty
  [xml|
    <head>
      <title>
        $maybe title <- M.lookup "title" attrs
          \#{title}
        $nothing
          Untitled Document
    <body>
        $forall child <- children
          ^{goNode child}
  |]

goNode :: Node -> [Node]
goNode (NodeElement e) = [NodeElement $ goElem e]
goNode (NodeContent t) = [NodeContent t]
goNode (NodeComment _) = []
goNode (NodeInstruction _) = []

goElem :: Element -> Element
goElem (Element "para" attrs children) = Element "p" attrs $ concatMap goNode children
goElem (Element "em" attrs children) = Element "i" attrs $ concatMap goNode children
goElem (Element "strong" attrs children) = Element "b" attrs $ concatMap goNode children
goElem (Element "image" attrs children) = Element "img" (fixAttr attrs) []
  where
    fixAttr mattrs
      | "href" `M.member` mattrs = M.delete "href" $ M.insert "src" (mattrs M.! "href") mattrs
      | otherwise                = mattrs
goElem (Element name attrs children) = Element name attrs $ concatMap goNode children


