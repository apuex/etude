{-# LANGUAGE OverloadedStrings #-}
module Main (main) where

import           CmdLine
import           Config
import           Control.Concurrent                      (forkIO)
import           Control.Monad.Trans                     (liftIO)
import           Data.List.Split
import qualified Data.Text                            as T
import qualified Data.Text.Lazy                       as TL
import           Network.AMQP
import           Network.Socket
import qualified Data.ByteString.Lazy.Char8           as BL
import           System.Environment
import           Text.Printf


main :: IO ()
main = do
    progName <- getProgName
    args     <- getArgs
    opts     <- loadOpts progName args defaultOptions

    putStrLn $ TL.unpack $ formatOptions opts

    conn <- openConnection' (mqBrokerHost opts)
                            (mqBrokerPort opts)
                            "/"
                            (T.pack $ mqBrokerUser opts)
                            (T.pack $ mqBrokerPassword opts)
    chan <- openChannel conn

    -- declare a queue, exchange and binding
    declareQueue chan newQueue {queueName = "myQueue"}
    declareExchange chan newExchange {exchangeName = (T.pack $ mqRequestDest opts), exchangeType = "direct"}
    bindQueue chan "myQueue" (T.pack $ mqRequestDest opts) "myKey"

    -- subscribe to the queue
    consumeMsgs chan "myQueue" Ack myCallback

    let loop = do
            -- publish a message to our new exchange
            l <- getLine -- wait for keypress
            publishMsg chan (T.pack $ mqRequestDest opts) "myKey"
                newMsg {msgBody = (BL.pack l),
                        msgDeliveryMode = Just Persistent}
            loop
    loop
    -- closeConnection conn
    --putStrLn "connection closed"


myCallback :: (Message,Envelope) -> IO ()
myCallback (msg, env) = do
    putStrLn $ "received message: " ++ (BL.unpack $ msgBody msg)
    -- acknowledge receiving the message
    ackEnv env