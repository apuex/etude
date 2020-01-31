{-# LANGUAGE OverloadedStrings #-}
module Main
    ( main
    ) where

import           Control.Concurrent  (forkIO)
import           Control.Monad       (forever, unless)
import           Control.Monad.Trans (liftIO)
import           Network.Socket      (withSocketsDo)
import           Data.Text           (Text)
import           Data.HashMap.Strict (delete)
import qualified Data.Text           as T
import qualified Data.Text.IO        as T
import qualified Network.WebSockets  as WS
import qualified Data.ByteString.Lazy.Char8 as BL
import Data.Aeson (FromJSON, ToJSON, decode, encode, Object)
import           Messages

app :: WS.ClientApp ()
app conn = do
    putStrLn "Connected!"

    let loop = do
            msg <- WS.receiveData conn
            let o = decode msg :: Maybe EventEnvelope
            case o of
                Just d ->
                    liftIO $ BL.putStrLn $ (encode . (delete "@type") . event) d
                Nothing ->
                    liftIO $ putStrLn "Unparsable."
                    -- return ()

            loop

    WS.withPingThread conn 30 (return ()) $ do
        loop

    WS.sendClose conn ("Bye!" :: Text)

main :: IO ()
main = withSocketsDo $ WS.runClient "concerto" 8000 "/api/events" app
