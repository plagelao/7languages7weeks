module Prime where
  primes = 1:2:3:(nextPrimes [3,2])

  nextPrimes :: [Int] -> [Int]
  nextPrimes primesFounded = nextPrime:(nextPrimes (nextPrime:primesFounded))
    where lastPrime = head primesFounded
          nextPrime = findNextPrime (lastPrime + 2)
          findNextPrime candidate
            | isPrime candidate = candidate
            | otherwise = findNextPrime (candidate + 2)
          isPrime candidate = all (/=0) (map (mod candidate) primesFounded)
