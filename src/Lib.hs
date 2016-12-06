module Lib where

import Control.Monad.Par

-- import Control.Monad.Par.Scheds.Trace

asdf :: (NFData a, Num a, Enum a) => a -> a -> a
asdf m n = runPar $ do
      i <- new                          -- 1
      j <- new                          -- 2
      fork (put i (sumv n))              -- 3
      fork (put j (sumv m))              -- 4
      a <- get i                        -- 5
      b <- get j                        -- 6
      return (a + b) where
        sumv nn = sum [0 .. nn]

