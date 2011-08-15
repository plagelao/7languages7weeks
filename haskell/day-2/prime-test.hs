module Primes_Test where
  import Prime( primes )
  import Test.HUnit

  tests = TestList [
    [1] ~=? take 1 (primes),
    [1,2] ~=? take 2 (primes),
    [1,2,3] ~=? take 3 (primes),
    [1,2,3,5] ~=? take 4 (primes),
    [1,2,3,5,7] ~=? take 5 (primes),
    [1,2,3,5,7,11] ~=? take 6 (primes),
    [1,2,3,5,7,11,13] ~=? take 7 (primes),
    [1,2,3,5,7,11,13,17] ~=? take 8 (primes)
    ]

  main = runTestTT tests
