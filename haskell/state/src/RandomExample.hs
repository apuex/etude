module RandomExample where

import Control.Applicative (liftA3)
import Control.Monad (replicateM)
import Control.Monad.Trans.State
import System.Random

data Die = 
    DieOne
  | DieTwo
  | DieThree
  | DieFour
  | DieFive
  | DieSix
  deriving (Eq, Show)

intToDie :: Int -> Die
intToDie n = 
  case n of
    1 -> DieOne
    2 -> DieTwo
    3 -> DieThree
    4 -> DieFour
    5 -> DieFive
    6 -> DieSix
    x -> error $ "intToDie got non 1-6 integer: " ++ show x

rollDieThreeTimes :: (Die, Die, Die)
rollDieThreeTimes = do {
    let s = mkStdGen 0
        (d1, s1) = randomR (1::Int, 6::Int) s
        (d2, s2) = randomR (1::Int, 6::Int) s1
        (d3, _) = randomR (1::Int, 6::Int) s2
    in
        (intToDie d1, intToDie d1, intToDie d1)
}

type RandomState a = State StdGen a

rollDie :: State StdGen Die
roleDie = state $ do
    (n, s) <- randomR (1:Int, 6::Int)
    return (intToDie n, s)
