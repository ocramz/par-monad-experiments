module Main where

import System.Environment

-- import Control.Parallel.Strategies
import Control.Monad.Par hiding (runPar)
import Control.Monad.Par.Scheds.Trace (runPar)

import Criterion.Main

import Lib

-- import Text.Printf (printf)




-- main = defaultMain
--   [bgroup "parFib1"
--       [
--       bench (benchTitle m n) $ whnf (parFib1 m) n
--       ]
--   ] where
--    (m, n) = (34, 35)

main :: IO ()
main =
  defaultMain [
    env setupEnv $ \ ~(m, n) ->   -- NB: lazy pattern match
     bgroup "parFib1"
       [
       bench (benchTitle m n) $ whnf (parFib1 m) n
       ]
   ] where
  setupEnv = do
    args <- getArgs
    let [m, n] = map read args :: [Integer]
    return (m, n)

benchTitle :: (Show a1, Show a) => a -> a1 -> String
benchTitle a b = unwords ["m =", show a,", n =", show b]



-- * Payload functions

parFib1 :: Integer -> Integer -> Integer
parFib1 m n = runPar $ do
      i <- new                          -- 1
      j <- new                          -- 2
      fork (put i (fib n))              -- 3
      fork (put j (fib m))              -- 4
      a <- get i                        -- 5
      b <- get j                        -- 6
      return (a + b) where

parQuickSort2 :: (Ord a , NFData a ) => Int -> [a] -> Par [a]
parQuickSort2 0 xs = return $ quickSort xs
parQuickSort2 d [ ] = return [ ]
parQuickSor2t d ( x : xs ) = do
  p1 <- spawn ( parQuickSort2 (d - 1) ( filter ( < x ) xs ) )
  p2 <- spawn ( parQuickSort2 (d - 1) ( filter ( >= x ) xs ) )
  left <- get p1
  right <- get p2
  return $ left ++ ( x : right )

quickSort :: Ord a => [a] -> [a]
quickSort [] = []
quickSort (x:xs) =
  quickSort [y | y <- xs, y < x ] ++ [x] ++ quickSort [y | y <- xs, y >= x ]


 
