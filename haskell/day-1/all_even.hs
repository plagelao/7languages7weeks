module Main where
  allEven :: [Integer] -> [Integer]
  allEven [] = []
  allEven(h:t) = if even h then h:allEven t else allEven t

  allEven2 :: [Integer] -> [Integer]
  allEven2(list) = [ x | x <- list, even x]

  allEven3 :: [Integer] -> [Integer]
  allEven3(list) = filter (\x -> even x) list
