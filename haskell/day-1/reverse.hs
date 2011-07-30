module Main where
  myReverse :: [a] -> [a]
  myReverse [] = []
  myReverse(h:t) = myReverse(t) ++ [h]
