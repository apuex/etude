{-# LANGUAGE QuasiQuotes #-}

module Main
       where

import Text.Printf
import Text.Regex.Posix
import Text.RawString.QQ

haystack :: String
haystack = "My e-mail address is user@example.com"

needle :: String
needle = [r|\w+@[a-zA-Z_]+?\.[a-zA-Z]{2,3}|]

multiline :: String
multiline = [r|<HTML>
    <HEAD>
        <TITLE>Auto-generated html formated source</TITLE>
        <META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
    </HEAD>
    <BODY LINK="#0000ff" VLINK="#800080" BGCOLOR="#ffffff">
        <P> </P>
        <PRE>
        </PRE>
    </BODY>
</HTML>
|]

main :: IO ()
main = do
  printf multiline
  printf "\n"
  printf "%s\n" ((haystack =~ needle) :: String)
  -- the following line produces an error at compile time.
  -- printf $ "%s\n" ((haystack =~ needle) :: String)
