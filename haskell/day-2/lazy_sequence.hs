module Main where
  everyThirdNumber x = x:(everyThirdNumber (x+3))
  everyFifthNumber y = y:(everyFifthNumber (y+5))
  everyEighthNumber x y = zipWith (+) (everyThirdNumber x) (everyFifthNumber y)
