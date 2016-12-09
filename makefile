N = 1000000

all:
	make build
	make run

build:
	stack build --ghc-options -threaded --ghc-options -O2

# run:
# 	stack exec parallel-experiments -- +RTS -N1 -RTS $N
# 	stack exec parallel-experiments -- +RTS -N2 -RTS $N

bench:
	make build
	# stack exec par-monad-experiments -- +RTS -N1 -RTS --output benchN1.html
	# stack exec par-monad-experiments -- +RTS -N2 -RTS --output benchN2.html
	stack exec par-monad-experiments -- 34 35 +RTS -N1 -RTS --output benchN1.html
	stack exec par-monad-experiments -- 34 35 +RTS -N2 -RTS --output benchN2.html
