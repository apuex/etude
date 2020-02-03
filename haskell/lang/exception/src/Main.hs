module Main(main) where

import           System.IO
import           System.IO.Error
import qualified Control.Exception as E
import           Control.Monad(unless)
import           Data.Char(toUpper)

main :: IO ()
main = do
    result <- E.try (getLine) :: IO (Either E.SomeException String)
    case result of
        Left  e -> print "error"
        Right n -> print n
