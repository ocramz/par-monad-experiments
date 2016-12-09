module Lib where

-- import Control.Monad.Par


-- import Control.Monad.Par.Scheds.Trace



fib :: Integer -> Integer
fib 0 = 1
fib 1 = 1
fib n = fib (n-1) + fib (n-2)
