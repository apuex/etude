module Main(main) where

import Control.Monad.State

type MyState = Int

stateValue :: MyState -> Int
stateValue s = s

nextState :: MyState -> MyState
nextState s = s + 1

type MyStateMonad = State MyState

getNext :: MyStateMonad Int
getNext = state (\st -> let st' = nextState(st) in (stateValue(st'), st'))

main :: IO ()
main = do
  print (evalState getNext 0)
  print (evalState getNext 1)

