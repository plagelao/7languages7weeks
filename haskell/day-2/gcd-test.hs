module GCD_Test where
  import GCD( gcd )
  import Test.HUnit

  tests = TestList [
    primeNumbers,
    anyNumbers
    ]

  primeNumbers = TestList [
    anyNumberIsOne,
    bothNumbersAreEqual,
    oneNumberIsMultipleOfTheOther]

  anyNumberIsOne = TestList [
    1 ~=? GCD.gcd 1 1,
    1 ~=? GCD.gcd 1 2,
    1 ~=? GCD.gcd 2 1
    ]

  bothNumbersAreEqual= TestList [
    2 ~=? GCD.gcd 2 2,
    3 ~=? GCD.gcd 3 3
    ]

  oneNumberIsMultipleOfTheOther = TestList [
    2 ~=? GCD.gcd 4 2,
    2 ~=? GCD.gcd 2 4
    ]

  anyNumbers = TestList [
    2 ~=? GCD.gcd 6 4,
    3 ~=? GCD.gcd 9 6
    ]

  main = runTestTT tests
